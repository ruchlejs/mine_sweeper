# Mine Sweeper

This project aims to modernize the classic Minesweeper game with a fresh and engaging interface, offering enhanced gameplay experiences while retaining the essence of the original game.

## Features

- A sleek and responsive user interface built with **Vue.js**.
- A robust and scalable backend powered by **Elixir** and the **Phoenix Framework**.
- Seamless integration between the frontend and backend for real-time updates.
- User authentication and profile management.
- Difficulty settings for players of all skill levels.

## Technology Stack

### Frontend

- **Vue.js**: A progressive JavaScript framework for building user interfaces.
- **Pinia**: For state management.
- **Element Plus**: For modern and accessible UI components.

### Backend

- **Elixir**: A dynamic, functional programming language designed for building scalable and maintainable applications.
- **Phoenix Framework**: For real-time web functionalities and API development.
- **PostgreSQL**: As the database solution for persistent storage.

## Project Structure

The project is organized into two main directories:

- `frontend/`: Contains all the code related to the Vue.js frontend.
- `backend/`: Contains the Elixir Phoenix backend.

## Installation

Follow these steps to set up the project locally:

### Prerequisites

- Node.js and npm (for the frontend)
- Elixir and Phoenix Framework (for the backend)
- PostgreSQL database

### Steps

1. **Clone the repository:**

   ```bash
   git clone git@github.com:ruchlejs/mine_sweeper.git
   cd mine_sweeper
   ```

2. **Install dependencies:**

   ```bash
   npm install
   ```

   This command will automatically install dependencies for both the frontend and backend using the custom script defined in the `package.json`.

3. **Configure the backend:**

   1. _Set Up the Environment Variables_

      - Create and configure your `.env` file inside the `backend/` directory with the necessary database credentials and other environment variables. It should look like this:

        ```ini
        DATABASE_URL=<url_to_database>
        PHX_HOST=<DNS_public_server>
        SECRET_KEY_BASE=<secret_key>
        GUARDIAN_SECRET_KEY="<Guardian_secret_key>"
        ```
> [!IMPORTANT]  
> The first three elements are only required for production configuration. In the development environment, the database can be managed locally as explain in [3](#db).

   2. _Generate Secret Keys_

      - Generate a Guardian secret key and add it to your `.env` file:
        
        ```bash
        mix guardian.gen.secret
        ```
      - Generate another secret key required for Phoenix:
        
        ```bash
        mix phx.gen.secret
        ```
<a id="db"></a>

   3. _Configure the Database_
   
      - Ensure your database configuration in `config/dev.exs` matches the following setup:

        ```elixir
        config :backend, Backend.Repo,
          username: "postgres",
          password: "postgres",
          hostname: "localhost",
          database: "backend_dev",
          stacktrace: true,
          show_sensitive_data_on_connection_error: true,
          pool_size: 10
        ```

   4. _Set Up the Database_
      - Navigate to the backend directory and run the following command to create and migrate the database:
   
        ```bash
        cd backend
        mix ecto.setup
        ```

4. **Start the development servers:**
   ```bash
   npm run dev
   ```
   This will launch both the frontend and backend servers in parallel.

## Running Tests

- **Frontend:**
  <!-- ```bash
  npm run test --prefix frontend
  ``` -->
  _In developpement_
- **Backend:**
  ```bash
  cd backend
  mix test
  ```

## Deployment

1. Build the frontend:
   
   ```bash
   npm run build
   ```
2. Start the backend in production mode:
   
   ```bash
   npm run start
   ```

## Contribution

Contributions are welcome! Feel free to open issues or submit pull requests to improve the project.
