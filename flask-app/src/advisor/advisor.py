from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


advisor = Blueprint('advisor', __name__)

# Get all advisor from the DB
@advisor.route('/advisor', methods=['GET'])
def get_advisors():
    cursor = db.get_db().cursor()
    cursor.execute('select * from advisor')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get advisor detail for a specific advisor 
@advisor.route('/advisor/<aID>', methods=['GET'])
def get_advisor(aID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from advisot where advisorID = {0}'.format(aID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
