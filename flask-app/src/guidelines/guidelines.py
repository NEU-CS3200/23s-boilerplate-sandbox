import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

guidelines = Blueprint('guidelines', __name__)
# Get all user interactions from the database
@guidelines.route('/guidelines', methods = ['GET'])
def get_guidelines():
     # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT GuidelineID, Content, UpdateDate FROM Guidelines')

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


@guidelines.route('/guidelines/moderator_id/<moderator_id>', methods=['GET'])
def get_guidelines_detail_moderator_id (moderator_id):

    query = 'SELECT ModeratorID, GuidelineID, Content, UpdateDate FROM Guidelines WHERE ModeratorID = ' + str(moderator_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@guidelines.route('/guidelines/guideline_id/<guideline_id>', methods=['GET'])
def get_guidelines_detail_guideline_id (guideline_id):

    query = 'SELECT ModeratorID, GuidelineID, Content, UpdateDate FROM Guidelines WHERE GuidelineID = ' + str(guideline_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@guidelines.route('/guidelines/<guideline_id>', methods=['PUT'])
def update_guideline(guideline_id):

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    moderator_id = the_data['ModeratorID']
    content = the_data['Content']
    update_date = the_data['UpdateDate']

    # Constructing the query
    query = 'update Guidelines set '

    query += 'ModeratorId = ' + str(moderator_id) + ', '
    query += 'Content = "' + content + '", '
    query += 'UpdateDate = "' + update_date + '"'

    query += 'where GuidelineID = '
    query += str(guideline_id)
    query += ";"
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@guidelines.route('/guidelines/<guideline_id>', methods=['DELETE'])
def delete_guideline (guideline_id):

    query = 'DELETE FROM Guidelines WHERE GuidelineID = ' + str(guideline_id)
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'