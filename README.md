# Minesweeper

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

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd mine_sweeper
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

   This command will automatically install dependencies for both the frontend and backend using the custom script defined in the `package.json`.

3. Configure the backend:

   - Create and configure your `.env` file in the `backend/` directory with database credentials and other necessary environment variables.
   - You need to add a Guardian secret key in your `.env` file named `GUARDIAN_SECRET_KEY`. You can generate one by running:
     ```
     mix guardian.gen.secret
     ```
   - Ensure your database configuration matches the following setup (from `dev.exs`):
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
   - Run the following commands to set up the database:
     ```bash
     cd backend
     mix ecto.setup
     ```

4. Start the development servers:
   ```bash
   npm run dev
   ```
   This will launch both the frontend and backend servers in parallel.

<!-- ## Running Tests

- **Frontend:**
  ```bash
  npm run test --prefix frontend
  ```
- **Backend:**
  ```bash
  cd backend
  mix test
  ``` -->

## Deployment

1. Build the frontend:
   ```bash
   npm run build --prefix frontend
   ```
2. Start the backend in production mode:
   ```bash
   cd backend
   MIX_ENV=prod mix phx.server
   ```

## Contribution

Contributions are welcome! Feel free to open issues or submit pull requests to improve the project.
