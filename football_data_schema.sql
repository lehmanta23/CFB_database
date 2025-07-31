
-- Drop tables if they exist (in reverse FK order)
DROP TABLE IF EXISTS success, epa, pff_defense, pff_blocking, pff_receiving, pff_rushing, pff_passing, plays, drives, games, teams CASCADE;

-- TEAMS
CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    conference VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(50)
);

-- GAMES
CREATE TABLE games (
    game_id BIGINT PRIMARY KEY,
    year INTEGER NOT NULL,
    week INTEGER NOT NULL,
    home_team_id BIGINT NOT NULL,
    home VARCHAR(100),
    away_team_id BIGINT NOT NULL,
    away VARCHAR(100),
    home_score INTEGER,
    away_score INTEGER,
    FOREIGN KEY (home_team_id) REFERENCES teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES teams(team_id)
);

-- DRIVES
CREATE TABLE drives (
    drive_id BIGINT PRIMARY KEY,
    game_id BIGINT NOT NULL,
    drive_num INTEGER,
    pos_team_id BIGINT,
    pos_team VARCHAR(100),
    drive_result VARCHAR(100),
    drive_yards INTEGER,
    drive_start_yards_to_goal INTEGER,
    drive_end_yards_to_goal INTEGER,
    drive_points INTEGER,
    drive_time_minutes_start INTEGER,
    drive_time_seconds_start INTEGER,
    drive_time_minutes_end INTEGER,
    drive_time_seconds_end INTEGER,
    drive_time_minutes_elapsed INTEGER,
    drive_time_seconds_elapsed INTEGER,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (pos_team_id) REFERENCES teams(team_id)
);

-- PLAYS
CREATE TABLE plays (
    id_play BIGINT PRIMARY KEY,
    game_id BIGINT NOT NULL,
    game_play_number INTEGER,
    drive_id BIGINT,
    half INTEGER,
    period INTEGER,
    clock_minutes INTEGER,
    clock_seconds INTEGER,
    time_secs_rem INTEGER,
    pos_team VARCHAR(100),
    pos_team_id BIGINT,
    def_pos_team VARCHAR(100),
    def_pos_team_id BIGINT,
    play_type VARCHAR(100),
    play_text TEXT,
    pass INTEGER,
    pass_attempt INTEGER,
    completion INTEGER,
    rush INTEGER,
    yards_gained INTEGER,
    down INTEGER,
    distance INTEGER,
    yards_to_goal INTEGER,
    epa FLOAT,
    def_epa FLOAT,
    wpa FLOAT,
    ep_before FLOAT,
    ep_after FLOAT,
    wp_before FLOAT,
    wp_after FLOAT,
    sack INTEGER,
    int INTEGER,
    penalty_detail VARCHAR(255),
    yds_penalty INTEGER,
    firstd_by_penalty INTEGER,
    firstd_by_yards INTEGER,
    success INTEGER,
    turnover INTEGER,
    turnover_downs INTEGER,
    score_pts INTEGER,
    scoring_play INTEGER,
    defense_score_play INTEGER,
    change_of_poss INTEGER,
    off_timeout INTEGER,
    off_timeouts_rem_before INTEGER,
    def_timeout INTEGER,
    def_timeouts_rem_before INTEGER,
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (drive_id) REFERENCES drives(drive_id),
    FOREIGN KEY (pos_team_id) REFERENCES teams(team_id),
    FOREIGN KEY (def_pos_team_id) REFERENCES teams(team_id)
);

-- PASSING
CREATE TABLE pff_passing (
    team_id INTEGER PRIMARY KEY,
    team_name VARCHAR(100),
    attempts INTEGER,
    avg_depth_of_target FLOAT,
    avg_time_to_throw FLOAT,
    big_time_throws INTEGER,
    completion_percentage FLOAT,
    completions INTEGER,
    def_gen_pressures INTEGER,
    dropbacks INTEGER,
    drops INTEGER,
    grade_offense FLOAT,
    grade_passing FLOAT,
    grade_run FLOAT,
    hit_as_threw INTEGER,
    interceptions INTEGER,
    sacks INTEGER,
    scrambles INTEGER,
    thrown_away INTEGER,
    touchdowns INTEGER,
    turnover_worthy_plays INTEGER,
    yards INTEGER,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- RUSHING
CREATE TABLE pff_rushing (
    team_id INTEGER PRIMARY KEY,
    team_name VARCHAR(100),
    attempts INTEGER,
    avoided_tackles INTEGER,
    breakaway_yards INTEGER,
    first_downs INTEGER,
    fumbles INTEGER,
    grades_offense FLOAT,
    grades_pass_block FLOAT,
    grades_run FLOAT,
    rec_yards INTEGER,
    receptions INTEGER,
    routes INTEGER,
    scramble_yards INTEGER,
    targets INTEGER,
    touchdowns INTEGER,
    yards INTEGER,
    yards_after_contact INTEGER,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- RECEIVING
CREATE TABLE pff_receiving (
    team_id INTEGER PRIMARY KEY,
    team_name VARCHAR(100),
    contested_receptions INTEGER,
    contested_targets INTEGER,
    grades_offense FLOAT,
    grades_pass_route FLOAT,
    receptions INTEGER,
    routes INTEGER,
    yards INTEGER,
    yards_after_catch INTEGER,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- BLOCKING
CREATE TABLE pff_blocking (
    team_id INTEGER PRIMARY KEY,
    team_name VARCHAR(100),
    grades_offense FLOAT,
    grades_pass_block FLOAT,
    grades_run_block FLOAT,
    hits_allowed INTEGER,
    hurries_allowed INTEGER,
    penalties INTEGER,
    pressures_allowed INTEGER,
    sacks_allowed INTEGER,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- DEFENSE
CREATE TABLE pff_defense (
    team_id INTEGER PRIMARY KEY,
    team_name VARCHAR(100),
    batted_passes INTEGER,
    forced_fumbles INTEGER,
    fumble_recoveries INTEGER,
    grades_coverage_defense FLOAT,
    grades_defense FLOAT,
    grades_pass_rush_defense FLOAT,
    grades_run_defense FLOAT,
    grades_tackle FLOAT,
    hits INTEGER,
    hurries INTEGER,
    interceptions INTEGER,
    missed_tackles INTEGER,
    pass_break_ups INTEGER,
    penalties INTEGER,
    qb_rating_against FLOAT,
    receptions INTEGER,
    sacks FLOAT,
    safeties INTEGER,
    stops INTEGER,
    tackles INTEGER,
    tackles_for_loss FLOAT,
    total_pressures INTEGER,
    touchdowns INTEGER,
    yards INTEGER,
    yards_after_catch INTEGER,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- EPA
CREATE TABLE epa (
    team_id INTEGER PRIMARY KEY,
    epa_per_play FLOAT,
    def_epa_per_play FLOAT,
    total_epa FLOAT,
    def_total_epa FLOAT,
    passing_epa_per_play FLOAT,
    def_passing_epa_per_play FLOAT,
    passing_total_epa FLOAT,
    def_passing_epa_total FLOAT,
    rushing_epa_per_play FLOAT,
    def_rushing_epa_per_play FLOAT,
    rushing_total_epa FLOAT,
    def_rushing_total_epa FLOAT,
    firstdown_epa_per_play FLOAT,
    def_firstdown_epa_per_play FLOAT,
    seconddown_epa_per_play FLOAT,
    def_seconddown_epa_per_play FLOAT,
    thirddown_epa_per_play FLOAT,
    def_thirddown_epa_per_play FLOAT,
    fourthdown_epa_per_play FLOAT,
    def_fourthdown_epa_per_play FLOAT,
    redzone_epa_per_play FLOAT,
    def_redzone_epa_per_play FLOAT,
    redzone_total_epa FLOAT,
    def_redzone_total_epa FLOAT,
    past40_epa_per_play FLOAT,
    def_past40_epa_per_play FLOAT,
    past40_total_epa FLOAT,
    def_past40_total_epa FLOAT,
    total_penalty_epa FLOAT,
    def_total_penalty_epa FLOAT,
    timeout_total_epa FLOAT,
    def_timeout_total_epa FLOAT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

-- SUCCESS
CREATE TABLE success (
    team_id INTEGER PRIMARY KEY,
    success_rate FLOAT,
    def_success_rate FLOAT,
    passing_success_rate FLOAT,
    def_passing_success_rate FLOAT,
    rushing_success_rate FLOAT,
    def_rushing_success_rate FLOAT,
    firstdown_success_rate FLOAT,
    def_firstdown_success_rate FLOAT,
    seconddown_success_rate FLOAT,
    def_seconddown_success_rate FLOAT,
    thirddown_success_rate FLOAT,
    def_thirddown_success_rate FLOAT,
    fourthdown_success_rate FLOAT,
    def_fourthdown_success_rate FLOAT,
    redzone_success_rate FLOAT,
    def_redzone_success_rate FLOAT,
    past40_success_rate FLOAT,
    def_past40_success_rate FLOAT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);
