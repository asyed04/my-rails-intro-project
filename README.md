# My Rails Intro Project

## Overview
This project is a **Football League Management System** built using **Ruby on Rails**. It allows users to explore **football leagues, teams, and players**, along with their statistics and history. The project includes features such as **search functionality, hierarchical navigation, pagination, and an interactive map** to visualize league locations.

## Features Implemented (Based on Grading Rubric)

### **1. Database & Models (ERD & Associations)**

#### **1.1 Describe Datasets (3 pts)**
The project uses **three datasets**:
1. **CSV Dataset** – Contains league data (name, country, number of teams)
2. **Faker-generated Data** – Creates teams and players with realistic names, positions, and statistics.
3. **External API Data** – Fetches real player data from the SportsDB API.

#### **1.2 Database ERD (5 pts)**
A detailed **Entity-Relationship Diagram (ERD)** is created, illustrating the relationships between `Leagues`, `Teams`, `Players`, and `PlayerTransfers`.

#### **1.3 ActiveRecord Models (8 pts)**
The project includes **four models**:
- `League`: Represents football leagues.
- `Team`: Belongs to a league and has multiple players.
- `Player`: Belongs to multiple teams (through `PlayerTransfer`).
- `PlayerTransfer`: Tracks player transfers between teams (Many-to-Many relationship).

#### **1.4-1.5 Associations (8 pts)**
- **One-to-Many Associations:**
  - `League has_many Teams`
  - `Team has_many Players`
- **Many-to-Many Association:**
  - `Player has_many Teams through PlayerTransfers`

#### **1.6 Validations (5 pts)**
Implemented validations for presence, uniqueness, and numerical values:
- `Player`: Validates `name`, `age` (between 18-40), `goals_scored` (>= 0)
- `Team`: Validates `name` (unique within a league)
- `League`: Validates `name` (unique)

#### **1.7 Data Sources (8 pts)**
- **CSV (db/seeds.rb)** – Populates the database with leagues.
- **Faker** – Generates realistic teams and players.
- **API (SportsDB)** – Fetches real player data.

---

### **2. Navigation & UI**

#### **2.1 About Page (3 pts)**
Includes an **About Page** explaining the project and dataset sources.

#### **2.2 Navigation Menu (5 pts)**
A **Bootstrap navbar** enables easy navigation between pages:
- Home
- Leagues
- Teams
- Players

---

### **3. Data Presentation & User Experience**

#### **3.1 Collection Navigation (3 pts)**
Users can browse:
- **All Leagues** (`/leagues`)
- **Teams within a League** (`/leagues/:id`)
- **Players within a Team** (`/teams/:id`)

#### **3.2 Member Pages (5 pts)**
Each league, team, and player has a **detailed profile page** displaying relevant information.

#### **3.3 Multi-Model Data on Member Pages (5 pts)**
- The **League Page** shows its teams.
- The **Team Page** lists its players.
- The **Player Page** shows career history and transfers.

#### **3.4 Hierarchical Collection Navigation (8 pts)**
- Clicking on a **League** shows its **Teams**.
- Clicking on a **Team** shows its **Players**.

#### **3.5 Pagination (5 pts)**
- **Kaminari** is used to paginate **players** for better usability.

#### **3.6 Interactive Mapping (8 pts)**
- **Leaflet.js** displays leagues' locations on an interactive **world map**.
- Clicking a **league** pin shows details.

---

### **4. Search & Filtering**

#### **4.1 Simple Search (3 pts)**
- Users can **search players by name**.

#### **4.2 Hierarchical Search (5 pts)**
- Users can **filter players by position** within teams.

---

### **5. Styling & UI Enhancements**

#### **5.1 Valid HTML (3 pts)**
- The project follows proper **HTML structure** and **valid ERB syntax**.

#### **5.2 ERB Conditional (3 pts)**
- Uses **ERB conditionals** to display **messages dynamically**, such as handling missing player data.

#### **5.3 Bootstrap Grid (5 pts)**
- Fully responsive UI using **Bootstrap Grid System**.

---

### **6. Version Control (Git & GitHub)**

#### **6.1 GIT & GitHub Usage (3 pts)**
- The project is tracked with **Git** and hosted on **GitHub**.

#### **6.2 20+ Git Commits (3 pts)**
- The repository contains **over 20 commits**, documenting project progress.

---

## **Final Notes**

### **How to Run the Project**
1. Clone the repository
   ```sh
   git clone <repo_link>
   cd my-rails-intro-project
   ```
2. Install dependencies
   ```sh
   bundle install
   yarn install
   ```
3. Set up the database
   ```sh
   rails db:setup
   ```
4. Start the Rails server
   ```sh
   rails server
   ```
5. Open `http://localhost:3000` in your browser.

### **Future Improvements**
- Add **team & player CRUD operations**.
- Improve **search filters**.
- Add **team transfer history pages**.

---

## **Contributors**
- **Syed Anvaar** – Developer

---

This project demonstrates a complete **Rails application** with **dynamic features**, an **interactive UI**, and well-structured **data relationships**! 🎉⚽

