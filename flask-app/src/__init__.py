# Some set up for the application 

from flask import Flask
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    app = Flask(__name__)
    
    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'

    # these are for the DB object to be able to connect to MySQL. 
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = open('/secrets/db_root_password.txt').readline().strip()
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_DB'] = 'cool_db'  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)
    
    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the 3200 boilerplate app</h1>"

    # Import the various Blueprint Objects
    from src.analytics.analytics import analytics
    from src.company_content.company_content import company_content
    from src.compensation_data.compensation_data import compensation_data
    from src.disputes.disputes import disputes
    from src.guidelines.guidelines import guidelines
    from src.job_openings.job_openings import job_openings
    from src.review_responses.review_responses import review_responses
    from src.reviews.reviews import reviews
    from src.students.students import students
    from src.user_interactions.user_interactions import user_interactions

    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each
    app.register_blueprint(job_openings, url_prefix='/jo')
    app.register_blueprint(reviews, url_prefix='/r')
    app.register_blueprint(disputes, url_prefix='/d')
    app.register_blueprint(user_interactions, url_prefix='/ui')
    app.register_blueprint(guidelines, url_prefix='/g')
    app.register_blueprint(analytics, url_prefix='/a')
    app.register_blueprint(review_responses, url_prefix='/rr')
    app.register_blueprint(company_content, url_prefix='/cc')
    app.register_blueprint(compensation_data, url_prefix='/cd')
    app.register_blueprint(students, url_prefix='/s')
    # Don't forget to return the app object
    return app