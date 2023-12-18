from flask import jsonify
from google.cloud import firestore

COLLECTION_ID = 'visitorCount'
DOCUMENT_ID = 'W7oWxRUwYew0tArbY1bd'

def queryCount():
    """
    Get the number of visitors

    :return: the number of visitors
    """
    try:
        database = firestore.Client()
        visitor_ref = database.collection(COLLECTION_ID).document(DOCUMENT_ID)
        doc = visitor_ref.get()
        
        if doc.exists:
            return int(doc.to_dict().get('visitorNumber', 0))
        else:
            return 0
    except Exception as e:
        print(f"Error getting visitor count: {e}")
        return 0


def updateCount(visitor_nb):
    """
    Updates the number of visitors to Firestore

    :param visitor_nb: number of visitors
    """
    try:
        database = firestore.Client()
        visitor_ref = database.collection(COLLECTION_ID).document(DOCUMENT_ID)
        visitor_ref.set({'visitorNumber': visitor_nb})
    except Exception as e:
        print(f"Error saving visitor data: {e}")


def visitorCount(request):
    """
    Handle the incoming HTTP request to increment the visitor count

    :param request: the client request
    :return: the updated visitor count as JSON response
    """
    try:
        visitor_nb = queryCount() + 1
        updateCount(visitor_nb)
        client_data = {'visitorNumber': str(visitor_nb)}
        headers = {'Access-Control-Allow-Origin': '*'}
        return jsonify(client_data), 200, headers
    except Exception as e:
        print(f"Error handling visitor count request: {e}")
        return jsonify({'error': 'Internal Server Error'}), 500, {'Access-Control-Allow-Origin': '*'}















# from google.cloud import recaptchaenterprise_v1
# from google.cloud.recaptchaenterprise_v1 import Assessment

# def create_assessment(
#     project_id: str, recaptcha_key: str, token: str, recaptcha_action: str
# ) -> Assessment:
#     """Create an assessment to analyze the risk of a UI action.
#     Args:
#         project_id: Your Google Cloud Project ID.
#         recaptcha_key: The reCAPTCHA key associated with the site/app
#         token: The generated token obtained from the client.
#         recaptcha_action: Action name corresponding to the token.
#     """

#     client = recaptchaenterprise_v1.RecaptchaEnterpriseServiceClient()

#     # Set the properties of the event to be tracked.
#     event = recaptchaenterprise_v1.Event()
#     event.site_key = recaptcha_key
#     event.token = token

#     assessment = recaptchaenterprise_v1.Assessment()
#     assessment.event = event

#     project_name = f"projects/{project_id}"

#     # Build the assessment request.
#     request = recaptchaenterprise_v1.CreateAssessmentRequest()
#     request.assessment = assessment
#     request.parent = project_name

#     response = client.create_assessment(request)

#     # Check if the token is valid.
#     if not response.token_properties.valid:
#         print(
#             "The CreateAssessment call failed because the token was "
#             + "invalid for the following reasons: "
#             + str(response.token_properties.invalid_reason)
#         )
#         return

#     # Check if the expected action was executed.
#     if response.token_properties.action != recaptcha_action:
#         print(
#             "The action attribute in your reCAPTCHA tag does"
#             + "not match the action you are expecting to score"
#         )
#         return
#     else:
#         # Get the risk score and the reason(s).
#         # For more information on interpreting the assessment, see:
#         # https://cloud.google.com/recaptcha-enterprise/docs/interpret-assessment
#         for reason in response.risk_analysis.reasons:
#             print(reason)
#         print(
#             "The reCAPTCHA score for this token is: "
#             + str(response.risk_analysis.score)
#         )
#         # Get the assessment name (id). Use this to annotate the assessment.
#         assessment_name = client.parse_assessment_path(response.name).get("assessment")
#         print(f"Assessment name: {assessment_name}")
#     return response