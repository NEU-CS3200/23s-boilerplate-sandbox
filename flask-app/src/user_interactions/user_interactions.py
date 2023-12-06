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

    query = 'SELECT ModeratorID, StudentID, InteractionID, UserTimestamp, Content, Status FROM User_Interaction WHERE InteractionID = ' + str(interaction_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@user_interactions.route('/user_interactions', methods=['POST'])
def add_new_user_interaction():
#ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status 
    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    moderator_id = the_data['ModeratorID']
    student_id = the_data['StudentID']
    interaction_id = random.randint(0,999999999)
    user_timestamp = the_data['UserTimestamp']
    content = the_data['Content']
    status = random.randint(0,1)


    # Constructing the query
    query = 'insert into User_Interaction (ModeratorID, StudentID, InteractionID, UserTimestamp, Content, Status) values ('

    query += str(moderator_id) + ', '
    
    query += str(student_id) + ', '
    query += str(interaction_id) + ', '
    query += '"' + user_timestamp + '", '
    query += '"' + content + '", '
    query += str(status) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@user_interactions.route('/user_interactions/interaction_id/<interaction_id>', methods=['PUT'])
def update_guideline(student_id):

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    moderator_id = the_data['ModeratorId']
    student_id = the_data['StudentID']
    interaction_id = the_data['InteractionID']
    user_timestamp = the_data['UserTimestamp']
    content = the_data['Content']
    status = the_data['Status']

    # Constructing the query
    #ModeratorId, StudentID, InteractionID, UserTimestamp, Content, Status
    query = 'update User_Interaction set '

    

    query += 'ModeratorId = ' + str(moderator_id) + ', '
    query += 'StudentID = ' + str(student_id) + ', ' 
    query += 'InteractionID = ' + str(interaction_id) + ', ' 
    query += 'UserTimestamp = ' + str(user_timestamp) + ', ' 
    query += 'Content = ' + '"' + content + '", ' 
    query += 'Status = ' + str(status) + '"'

    query += 'where InteractionID = '
    query += str(interaction_id)
    query += ";"
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@user_interactions.route('/user_interactions/interaction_id/<interaction_id>', methods=['DELETE'])
def delete_guideline (interaction_id):

    query = 'DELETE FROM Guidelines WHERE InteractionID = ' + str(interaction_id)
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'