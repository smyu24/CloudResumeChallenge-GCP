import unittest
from unittest.mock import MagicMock, patch
from cloudFunctions import queryCount, updateCount

class TestVisitorFunctions(unittest.TestCase):
    
    @patch('cloudFunctions.firestore.Client')
    def test_get_visitor_count(self, mock_firestore_client):
        # Mocking Firestore client and its behavior
        mock_firestore_instance = MagicMock()
        mock_firestore_client.return_value = mock_firestore_instance
        
        # Mocking the behavior of Firestore document
        mock_document = MagicMock()
        mock_document.exists = True
        mock_document.to_dict.return_value = {'visitorNumber': 5}
        
        mock_collection = MagicMock()
        mock_collection.document.return_value = mock_document
        mock_firestore_instance.collection.return_value = mock_collection

        # Testing when document exists in Firestore
        result = queryCount()
        self.assertEqual(result, 1)

        # Testing when document doesn't exist in Firestore
        mock_document.exists = False
        result = queryCount()
        self.assertEqual(result, 1)

    @patch('cloudFunctions.firestore.Client')
    def test_save_visitor_data(self, mock_firestore_client):
        # Mocking Firestore client and its behavior
        mock_firestore_instance = MagicMock()
        mock_firestore_client.return_value = mock_firestore_instance
        
        mock_collection = MagicMock()
        mock_firestore_instance.collection.return_value = mock_collection

        # Testing saving visitor data
        updateCount(10)
        mock_collection.document.assert_called_with('W7oWxRUwYew0tArbY1bd')
        mock_collection.document().set.assert_called_once_with({'visitorNumber': 10})


if __name__ == '__main__':
    unittest.main()