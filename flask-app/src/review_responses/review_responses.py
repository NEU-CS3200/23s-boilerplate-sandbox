import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

review_responses = Blueprint("review_responses", __name__)


# Get all user interactions from the database
@review_responses.route("/review_responses", methods=["GET"])
def get_review_responses():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute("SELECT CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate FROM Review_Response")

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


@review_responses.route("/review_responses/review_id/<review_id>", methods=["GET"])
def get_review_responses_detail_review_id(review_id):
    query = (
        "SELECT CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate FROM Review_Response WHERE ReviewID = "
        + str(review_id)
    )
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@review_responses.route('/review_responses', methods=['POST'])
def add_new_review_response():

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    response_id = random.randint(0,999999999)
    company_rep_id = the_data['CompanyRepID']
    review_id = the_data['ReviewID']
    response_content = the_data['ResponseContent']
    response_date = the_data['ResponseDate']

    # Constructing the query
    query = 'insert into Review_Response (CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate) values ('
    query += str(company_rep_id) + ', '
    query += str(review_id) + ', '
    query += str(response_id) + ', '
    query += '"' + response_content + '", '
    query += '"' + response_date + '") '
    current_app.logger.info(query)
    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'


@review_responses.route("/review_responses/company_rep_id/<company_rep_id>", methods=["GET"])
def get_review_responses_detail_review_responses_id(company_rep_id):
    query = (
       "SELECT CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate FROM Review_Response WHERE CompanyRepID = "
        + str(company_rep_id)
    )
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@review_responses.route('/review_responses/<response_id>', methods=['PUT'])
def update_review_responses(response_id):

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    company_rep_id = the_data['CompanyRepID']
    review_id = the_data['ReviewID']
    response_id = the_data['ResponseID']
    response_content = the_data['ResponseContent']
    response_date = the_data['ResponseDate']

    # Constructing the query
    query = 'update Review_Response set '

    query += 'CompanyRepID = ' + str(company_rep_id) + ', '
    query += 'ReviewID = ' + str(review_id) + ', '
    query += 'ResponseID = ' + str(response_id) + ', '
    query += 'ResponseContent = "' + response_content + '", '
    query += 'ResponseDate = "' + response_date + '" '

    query += 'where ResponseID = '
    query += str(response_id)
    query += ";"
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@review_responses.route('/review_responses/<response_id>', methods=['DELETE'])
def delete_review_response (response_id):

    query = 'DELETE FROM Review_Response WHERE ResponseID = ' + str(response_id)
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'