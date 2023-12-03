import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

company_content = Blueprint("company_content", __name__)


# Get all user interactions from the database
@company_content.route("/company_content", methods=["GET"])
def get_company_content():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute(
        "SELECT CompanyRepID, ContentID, ContentType, ContentData, PostDate FROM Company_Content"
    )

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@company_content.route('/company_content/<content_id>', methods=['PUT'])
def update_company_content(content_id):

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable

    company_rep_id = the_data['CompanyRepID']
    content_type = the_data['ContentType']
    content_data = the_data['ContentData']
    post_date = the_data['PostDate']
    # Constructing the query
    query = 'update Company_Content set '

    query += 'CompanyRepID = ' + str(company_rep_id) + ', '
    query += 'ContentType = "' + content_type + '", '
    query += 'ContentData = "' + content_data + '", '
    query += 'PostDate = "' + post_date + '" '

    query += 'where ContentID = '
    query += str(content_id)
    query += ";"
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@company_content.route('/company_content/<content_id>', methods=['DELETE'])
def delete_company_content (content_id):

    query = 'DELETE FROM Company_Content WHERE ContentID = ' + str(content_id)
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'