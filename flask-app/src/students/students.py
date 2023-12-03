import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

students = Blueprint('students', __name__)
# Get all students from the databas
@students.route('/students', methods = ['GET'])
def get_students():
     # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT Studentid, Name, Email, Major FROM Student')

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

@students.route('/students/<student_id>', methods=['GET'])
def get_student_detail (student_id):

    query = 'SELECT Studentid, Name, Email, Major, GradeYear, NumCoops FROM Student WHERE Studentid = ' + str(student_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)