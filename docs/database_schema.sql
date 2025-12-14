-- ========================================
-- Help Desk Database Schema
-- ========================================

-- Create database
CREATE DATABASE IF NOT EXISTS helpdesk_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE helpdesk_db;

-- ========================================
-- Table: users
-- ========================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'AGENT', 'USER') NOT NULL DEFAULT 'USER',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Table: tickets
-- ========================================
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('OPEN', 'IN_PROGRESS', 'RESOLVED') NOT NULL DEFAULT 'OPEN',
    priority ENUM('LOW', 'MEDIUM', 'HIGH') NOT NULL DEFAULT 'MEDIUM',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    assigned_to INT NULL,
    CONSTRAINT fk_tickets_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE RESTRICT,
    CONSTRAINT fk_tickets_assigned_to FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_priority (priority),
    INDEX idx_created_by (created_by),
    INDEX idx_assigned_to (assigned_to),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Table: ticket_comments
-- ========================================
CREATE TABLE ticket_comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    user_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_ticket FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_ticket_id (ticket_id),
    INDEX idx_user_id (user_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Insert Initial Admin User
-- ========================================
-- Note: Replace 'GENERATED_HASH_HERE' with the actual hash
-- Generate using: python -c "from werkzeug.security import generate_password_hash; print(generate_password_hash('admin123'))"

-- Example (you must replace with your actual hash):
-- INSERT INTO users (name, email, password_hash, role)
-- VALUES ('Admin', 'admin@example.com', 'scrypt:32768:8:1$...', 'ADMIN');

-- ========================================
-- Sample Data (Optional - for testing)
-- ========================================

-- Create additional test users (remember to generate proper hashes)
-- INSERT INTO users (name, email, password_hash, role) VALUES
-- ('Agent Smith', 'agent@example.com', 'HASH_HERE', 'AGENT'),
-- ('John User', 'user@example.com', 'HASH_HERE', 'USER');

-- Sample tickets (uncomment after creating users)
-- INSERT INTO tickets (title, description, priority, created_by, assigned_to) VALUES
-- ('Cannot login to system', 'I forgot my password and cannot access my account', 'HIGH', 3, 2),
-- ('Feature request: Dark mode', 'Would be nice to have a dark mode option', 'LOW', 3, NULL),
-- ('Bug: Search not working', 'The search function returns no results', 'MEDIUM', 3, 2);

-- Sample comments (uncomment after creating tickets)
-- INSERT INTO ticket_comments (ticket_id, user_id, comment) VALUES
-- (1, 2, 'I will help you reset your password. Please check your email.'),
-- (1, 3, 'Thank you! I received the email and can now login.'),
-- (3, 2, 'I am investigating this issue. Can you provide more details?');

-- ========================================
-- Verify Installation
-- ========================================
-- Check tables
-- SHOW TABLES;

-- Check users table structure
-- DESCRIBE users;

-- Check tickets table structure
-- DESCRIBE tickets;

-- Check ticket_comments table structure
-- DESCRIBE ticket_comments;
