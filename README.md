# **API Docs**

# Users API

**POST /users**
---
* **Method:**

    `POST`
  
*  **URL Params**

    None

*  **URL Query**

    None

* **Data Params**
 
    `email=[string]  (Required)`<br />
    `password=[string] (Required)`<br />


* **Success Response:**

    **Code:** 200 <br />
    **Content:** 
    ```json
    { 
      "id": <id>,
      "email": <email>,
      "token": <token>
    }
    ```
 
* **Error Response:**

    **Code:** 400 Bad Request <br />
    **Content:**
    ```json
    {
      "error": "Email already used"
    }
    ```

    OR

    **Code:** 400 Bad Request <br />
    **Content:**
    ```json
    {
      "error": "Invalid email or password"
    }
    ```

**POST /login**
---
* **Method:**

    `POST`
  
*  **URL Params**

    None

*  **URL Query**

    None

* **Data Params**
 
    `email=[string]  (Required)`<br />
    `password=[string] (Required)`<br />


* **Success Response:**

    **Code:** 200 <br />
    **Content:** 
    ```json
    { 
      "id": <id>,
      "email": <email>,
      "token": <token>
    }
    ```
 
* **Error Response:**

    **Code:** 400 Bad Request <br />
    **Content:**
    ```json
    {
      "error": "Email or password is wrong"
    }
    ```

**GET /api/v1/tasks**
---
* **Method:**

    `GET`
  
*  **URL Params**

    None

*  **URL Query**

    None

*  **Headers**

    `Authorization=Bearer <token> (Required)`

* **Data Params**

    None

* **Success Response:**

    **Code:** 200 <br />
    **Content:** 
    ```json
    { 
      [
        "id": <id>,
        "title": <title>,
        "description": <description>,
        "priorities": <priorities>,
        "due_date": <due_date>,
        "status": <status>,
        "user_id": <user_id>
      ]
    }
    ```
 
* **Error Response:**

    **Code:** 401 Unauthorized <br />
    **Content:**
    ```json
    {
      "message": "Please log in"
    }
    ```

**POST /api/v1/tasks**
---
* **Method:**

    `POST`
  
*  **URL Params**

    None

*  **URL Query**

    None

*  **Headers**

    `Authorization=Bearer <token> (Required)`

* **Data Params**
 
    `title=[string]`<br />
    `description=[string]`<br />
    `priorities=[string]`<br />
    `due_date=[date]`<br />
    `status=[boolean]`<br />

* **Success Response:**

    **Code:** 200 <br />
    **Content:** 
    ```json
    { 
      "id": <id>,
      "title": <title>,
      "description": <description>,
      "priorities": <priorities>,
      "due_date": <due_date>,
      "status": <status>,
      "user_id": <user_id>
    }
    ```
 
* **Error Response:**

    **Code:** 401 Unauthorized <br />
    **Content:**
    ```json
    {
      "message": "Please log in"
    }
    ```

**PUT / PATCH /api/v1/tasks/:id**
---
* **Method:**

    `PUT / PATCH`
  
*  **URL Params**

    `id=[integer] (Required)`

*  **URL Query**

    None

*  **Headers**

    `Authorization=Bearer <token> (Required)`

* **Data Params**
 
    `title=[string]`<br />
    `description=[string]`<br />
    `priorities=[string]`<br />
    `due_date=[date]`<br />
    `status=[boolean]`<br />

* **Success Response:**

    **Code:** 200 <br />
    **Content:** 
    ```json
    { 
      "id": <id>,
      "title": <title>,
      "description": <description>,
      "priorities": <priorities>,
      "due_date": <due_date>,
      "status": <status>,
      "user_id": <user_id>
    }
    ```
 
* **Error Response:**

    **Code:** 401 Unauthorized <br />
    **Content:**
    ```json
    {
      "message": "Please log in"
    }
    ```

**DELETE /api/v1/tasks/:id**
---
* **Method:**

    `DELETE`
  
*  **URL Params**

    `id=[integer] (Required)`

*  **URL Query**

    None

*  **Headers**

    `Authorization=Bearer <token> (Required)`

* **Data Params**
 
    None

* **Success Response:**

    **Code:** 200 <br />
    **Content:** 
    ```json
    { 
      "message": "Task deleted."
    }
    ```
 
* **Error Response:**

    **Code:** 401 Unauthorized <br />
    **Content:**
    ```json
    {
      "message": "Please log in"
    }
    ```

