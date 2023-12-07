from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

sections = Blueprint('section', __name__)

# Get all students from the database 
@sections.route('/sections/<id>', methods=['GET'])
def get_section(id):
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    # use cursor to query the database for a list of students
    cursor.execute('SELECT * FROM section where secID = ' + str(id))

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


@sections.route('/sections/<id>', methods=['PUT'])
def modify_section(id):
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    classRoom = the_data['classroom']
    course = the_data['course']

    # Constructing the query
    query = 'update section set '
    query += "classroom = " + '"'+ str(classRoom) + '", '
    query += "course = " + str(course) + ' WHERE secID = ' + str(id)

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'