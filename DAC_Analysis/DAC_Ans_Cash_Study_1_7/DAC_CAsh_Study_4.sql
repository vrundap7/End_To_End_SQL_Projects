
--  CASE STUDY --------------------------------------------------------

CREATE DATABASE DAC;
USE DAC;


CREATE TABLE team (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    team_name VARCHAR(100),
    coach_name VARCHAR(100),
    home_ground VARCHAR(100)
);

-- Insert into team
INSERT INTO team (team_name, coach_name, home_ground) VALUES
('Mumbai Kings', 'Rahul Dravid', 'Wankhede Stadium'),
('Chennai Superstars', 'Stephen Fleming', 'Chepauk Stadium');

CREATE TABLE player (
    player_id INT PRIMARY KEY AUTO_INCREMENT,
    player_name VARCHAR(100),
    team_id INT,
    player_role VARCHAR(50),
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

-- Insert into player
INSERT INTO player (player_name, team_id, player_role) VALUES
('Rohit Sharma', 1, 'Batsman'),
('Jasprit Bumrah', 1, 'Bowler'),
('MS Dhoni', 2, 'Wicketkeeper'),
('Ravindra Jadeja', 2, 'All-rounder');

CREATE TABLE match_detail (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    team1_id INT,
    team2_id INT,
    match_date DATE,
    winner_team_id INT,
    FOREIGN KEY (team1_id) REFERENCES team(team_id),
    FOREIGN KEY (team2_id) REFERENCES team(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES team(team_id)
);

-- Insert into match_detail
INSERT INTO match_detail (team1_id, team2_id, match_date, winner_team_id) VALUES
(1, 2, '2024-07-10', 1),
(2, 1, '2024-07-15', 2);

CREATE TABLE performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    match_id INT,
    player_id INT,
    runs_scored INT,
    wickets_taken INT,
    FOREIGN KEY (match_id) REFERENCES match_detail(match_id),
    FOREIGN KEY (player_id) REFERENCES player(player_id)
);

-- Insert into performance
INSERT INTO performance (match_id, player_id, runs_scored, wickets_taken) VALUES
(1, 1, 70, 0),
(1, 2, 10, 2),
(1, 3, 60, 0),
(1, 4, 25, 1),
(2, 1, 30, 0),
(2, 2, 5, 3),
(2, 3, 45, 1),
(2, 4, 55, 2);

-- Q1. List all teams
SELECT * FROM team;

-- Q2. List all players with their team names
SELECT player.player_id, player.player_name, player.player_role, team.team_name
FROM player
JOIN team ON player.team_id = team.team_id;

-- Q3. List all matches with winning team names
SELECT match_detail.match_id, match_detail.match_date, team.team_name AS winner_team
FROM match_detail
JOIN team ON match_detail.winner_team_id = team.team_id;

-- Q4. List all players who are bowlers
SELECT player_id, player_name, team_id, player_role
FROM player
WHERE player_role = 'Bowler';

-- Q5. Show match details where team1 was "Mumbai Kings"
SELECT match_id, team1_id, team2_id, match_date, winner_team_id
FROM match_detail
WHERE team1_id = (
    SELECT team_id FROM team WHERE team_name = 'Mumbai Kings'
);
