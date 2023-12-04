from flask import Blueprint, request, jsonify, make_response
import json
from src import db


courses = Blueprint('courses', __name__)

# Get all courses from the DB
@courses.route('/courses', methods=['GET'])
def get_courses():
    cursor = db.get_db().cursor()
    cursor.execute('select name, term from course')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get course detail for a specfifc course
@courses.route('/courses/<cID>', methods=['GET'])
def get_course(cID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from customers where id = {0}'.format(cID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response