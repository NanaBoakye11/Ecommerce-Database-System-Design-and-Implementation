CREATE Table CUSTOMERS (
customer_id VARCHAR(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
first_name Varchar(50) NOT NULL, 
last_name Varchar(50) NOT NULL, 
email Varchar(100) NOT NULL UNIQUE, 
password_hash Varchar(255) NOT NULL,
phone Varchar(200) NOT NULL UNIQUE, 
address Varchar(200),
city Varchar(50),
country Varchar(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE CATEGORIES (
category_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
category_name varchar(50) NOT NULL,
sub_cat_name varchar(50),
sub_sub_cat_name varchar(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE PERMISSIONS (
permission_id INT NOT NULL AUTO_INCREMENT UNIQUE, 
permission_name varchar(50) NOT NULL,
level INT NOT NULL,
description varchar(255),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE SELLERS (
seller_id VARCHAR(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE, 
first_name varchar(50) NOT NULL,
last_name Varchar(50) NOT NULL, 
email Varchar(100) NOT NULL UNIQUE,
phone Varchar(200) NOT NULL UNIQUE,
password_hash Varchar(255) NOT NULL,
verification_id VARCHAR(8) UNIQUE,
sex ENUM('M', 'F', 'O'),
address Varchar(200) NOT NULL,
city Varchar(100),
country Varchar(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE VERIFICATIONS (
    verification_id VARCHAR(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
    seller_id VARCHAR(8) NOT NULL UNIQUE,
    government_id VARCHAR(50),
    bank_account VARCHAR(50),
    business_registration VARCHAR(500),
    status ENUM('received','pending', 'approved', 'rejected') DEFAULT 'received',
    comments TEXT,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    verification_date TIMESTAMP NULL,
    verified_by VARCHAR(100), 
    FOREIGN KEY (seller_id) REFERENCES SELLERS(seller_id)
);

ALTER TABLE SELLERS ADD CONSTRAINT fk_verification_id 
FOREIGN KEY (verification_id) REFERENCES VERIFICATIONS(verification_id); 

CREATE TABLE ROLES(
role_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
role_name varchar(50) NOT NULL UNIQUE,
description varchar(255),
permission_id INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY(permission_id) REFERENCES PERMISSIONS(permission_id)
);

CREATE TABLE EMPLOYEES (
	employee_id VARCHAR(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
    first_name varchar(50) NOT NULL,
    middle_name varchar(50),
	last_name varchar(50) NOT NULL,
    email varchar(100) NOT NULL UNIQUE,
    phone Varchar(200) NOT NULL UNIQUE,
    birthday date, 
    role_id INT NOT NULL,
    start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(role_id) REFERENCES ROLES(role_id)
);


CREATE TABLE DRIVERS (
driver_id varchar(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
employee_id VARCHAR(8) NOT NULL UNIQUE,
driver_license varchar(50) NOT NULL UNIQUE, 
vehicle_type ENUM('Motorcycle', 'Sedan', 'SUV') NOT NULL,
plate_number varchar(50),
num_of_deliveries INT DEFAULT 0,
profile_pic varchar(255),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY(employee_id) REFERENCES EMPLOYEES(employee_id)
);


CREATE TABLE CLERKS (
clerk_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
employee_id VARCHAR(8) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY(employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE PRODUCTS (
product_id varchar(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE, 
category_id INT,
product_name varchar(500) NOT NULL,
price DECIMAL(15, 2) NOT NULL, 
description varchar(500),
prod_reviews varchar(600),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY(category_id) REFERENCES CATEGORIES(category_id)
);

CREATE TABLE COLORS (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(50) NOT NULL UNIQUE
);



CREATE TABLE CARTS (
cart_id varchar(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
-- product_id varchar(8),
customer_id VARCHAR(8) NOT NULL,
total_qty INT DEFAULT 0,
total_amount DECIMAL(15, 2) DEFAULT 0.00,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE CART_ITEMS (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id varchar(8) NOT NULL,
    product_id varchar(8) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,  -- Quantity of each product in the cart
    price DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES CARTS(cart_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);

CREATE TABLE ORDERS (
	order_id varchar(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
	customer_id VARCHAR(8) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(15, 2) DEFAULT 0.00,  -- Total amount for the order
    status ENUM('pending', 'shipped', 'delivered', 'canceled') DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id) 
);

CREATE TABLE ORDER_ITEMS (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(8) NOT NULL,
    product_id VARCHAR(8) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(15, 2) NOT NULL,    -- Stores price per unit of the product at the time of the order
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
);



CREATE TABLE STORES (
store_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
seller_id VARCHAR(8) NOT NULL, 
store_name varchar(100) NOT NULL UNIQUE, 
country varchar(50),
city varchar(100),
postal_code varchar(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
store_logo varchar(255),
payment_info varchar(255),
website_url varchar(255),
reviews varchar(255),
FOREIGN KEY(seller_id) REFERENCES SELLERS(seller_id)
);

CREATE TABLE DELIVERIES (
delivery_id varchar(36) PRIMARY KEY NOT NULL DEFAULT (UUID()) UNIQUE,
delivery_address VARCHAR(255) NOT NULL,
driver_id varchar(8),
order_id VARCHAR(8) NOT NULL, 
delivery_method ENUM('standard', 'express', 'same-day', 'overnight') NOT NULL,
delivery_status ENUM('in-transit', 'out-for-delivery', 'delivered', 'delayed', 'missed-delivery', 'rescheduled', 'pending', 'scheduled') DEFAULT 'scheduled',
scheduled_delievery_time DATETIME,
actual_dt DATETIME,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
instructions TEXT,
FOREIGN KEY (driver_id) REFERENCES DRIVERS(driver_id),
FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);


CREATE TABLE INVENTORY (
	inventory_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    store_id INT, 
    product_id varchar(8),
    color_id INT NOT NULL,
    quantity INT,
	category_id INT,
	location varchar(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- PRIMARY KEY (product_id, color_id),
    FOREIGN KEY (store_id) REFERENCES STORES(store_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id),
    FOREIGN KEY (color_id) REFERENCES COLORS(color_id)
    
);















-- CREATE TABLE INVENTORY (
-- inventory_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
-- product_id INT NOT NULL,
-- quantity INT,
-- category_id INT,
-- location varchar(50),
-- FOREIGN KEY(product_id) REFERENCES 
-- )


-- DELIMITER //
-- CREATE TRIGGER before_insert_lowercase
-- BEFORE INSERT ON CUSTOMERS
-- FOR EACH ROW
-- BEGIN
--     -- Convert all specified fields to lowercase
--     SET NEW.first_name = LOWER(NEW.first_name);
--     SET NEW.last_name = LOWER(NEW.last_name);
--     SET NEW.email = LOWER(NEW.email);
--     SET NEW.address = LOWER(NEW.address);
--     SET NEW.city = LOWER(NEW.city);
--     SET NEW.country = LOWER(NEW.country);
-- END;
-- //
-- DELIMITER ;

-- DELIMITER //
-- CREATE TRIGGER after_update_lowercase
-- BEFORE UPDATE ON CUSTOMERS
-- FOR EACH ROW
-- BEGIN
--     SET NEW.first_name = LOWER(NEW.first_name);
--     SET NEW.last_name = LOWER(NEW.last_name);
--     SET NEW.email = LOWER(NEW.email);
--     SET NEW.address = LOWER(NEW.address);
--     SET NEW.city = LOWER(NEW.city);
--     SET NEW.country = LOWER(NEW.country);
-- END;
-- //
-- DELIMITER ;




-- DELIMITER //
-- CREATE TRIGGER before_insert_lowercase
-- BEFORE INSERT ON SELLERS
-- FOR EACH ROW
-- BEGIN
--     -- Convert all specified fields to lowercase
--     SET NEW.first_name = LOWER(NEW.first_name);
--     SET NEW.last_name = LOWER(NEW.last_name);
--     SET NEW.email = LOWER(NEW.email);
--     SET NEW.address = LOWER(NEW.address);
--     SET NEW.city = LOWER(NEW.city);
--     SET NEW.sex = LOWER(NEW.sex);
--     SET NEW.country = LOWER(NEW.country);
-- END;
-- //
-- DELIMITER ;

-- DELIMITER //
-- CREATE TRIGGER after_update_lowercase
-- BEFORE UPDATE ON SELLERS
-- FOR EACH ROW
-- BEGIN
--     SET NEW.first_name = LOWER(NEW.first_name);
--     SET NEW.last_name = LOWER(NEW.last_name);
--     SET NEW.email = LOWER(NEW.email);
--     SET NEW.address = LOWER(NEW.address);
--     SET NEW.city = LOWER(NEW.city);
--     SET NEW.sex = LOWER(NEW.sex);
--     SET NEW.country = LOWER(NEW.country);
-- END;
-- //
-- DELIMITER ;




