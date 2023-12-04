import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

user_interactions = Blueprint('user_interactions', __name__)
# Get all user interactions from the database
@user_interactions.route('/user_interactions', methods = ['GET'])
def get_user_interactions():
     # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status FROM User_Interaction')

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

@user_interactions.route('/user_interactions/moderator_id/<moderator_id>', methods=['GET'])
def get_user_interactions_detail_moderator_id (moderator_id):

    query = 'SELECT ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status FROM User_Interaction WHERE ModeratorID = ' + str(moderator_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@user_interactions.route('/user_interactions/student_id/<student_id>', methods=['GET'])
def get_user_interactions_detail_student_id (student_id):

    query = 'SELECT ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status FROM User_Interaction WHERE StudentID = ' + str(student_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@user_interactions.route('/user_interactions/interaction_id/<interaction_id>', methods=['GET'])
def get_user_interactions_detail_interaction_id (interaction_id):

    query = 'SELECT ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status FROM User_Interaction WHERE InteractionID = ' + str(interaction_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)