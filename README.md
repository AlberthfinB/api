
# Project API

// ...existing code...

## API Documentation

### Get Points by User

**Endpoint:** `GET /user/point`

**Description:** Retrieves points for a specific user.

**Query Parameters:**
- `user` (required): The ID of the user whose points are to be retrieved.

**Response:**
- `200 OK`: 
  - `message`: "Success"
  - `data`: Array of user points

**Example Request:**