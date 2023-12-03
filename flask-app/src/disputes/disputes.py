import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

disputes = Blueprint('disputes', __name__)
# Get all disputes from the database
@disputes.route('/disputes', methods = ['GET'])
def get_disputes():
     # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT DisputeID, ResolutionStatus, ResolutionDate FROM Dispute')

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

@disputes.route('/disputes', methods=['POST'])
def add_new_dispute():

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    review_id = the_data['ReviewID']
    moderator_id = the_data['ModeratorID']
    dispute_id = random.randint(0,999999999)
    resolution_status = the_data['ResolutionStatus']
    resolution_date = the_data['ResolutionDate']

    # Constructing the query
    query = 'insert into Dispute (ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate) values ('
    query += str(review_id) + ', '
    query += str(moderator_id) + ', '
    query += str(dispute_id) + ', "'
    query += resolution_status + '", "'
    query += resolution_date + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@disputes.route('/disputes/<dispute_id>', methods=['GET'])
def get_dispute_detail (dispute_id):
    query = 'SELECT ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate FROM Dispute WHERE DisputeID = ' + str(dispute_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@disputes.route('/disputes/moderator_id/<moderator_id>', methods=['GET'])
def get_dispute_detail_moderator_id (moderator_id):

    query = 'SELECT ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate FROM Dispute WHERE ModeratorID = ' + str(moderator_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@disputes.route('/disputes/review_id/<review_id>', methods=['GET'])
def get_dispute_detail_review_id (review_id):

    query = 'SELECT ReviewID, ModeratorID, DisputeID, ResolutionStatus, ResolutionDate FROM Dispute WHERE ReviewID = ' + str(review_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)