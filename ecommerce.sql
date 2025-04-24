-- =========================================
-- E-Commerce Database Schema and Data Setup
-- =========================================

-- DATABASE CREATION
CREATE DATABASE ecommerce;

-- TABLE CREATION
CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE product_category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    base_price NUMERIC(10, 2),
    description TEXT,
    brand_id INT REFERENCES brand(brand_id),
    category_id INT REFERENCES product_category(category_id)
);

CREATE TABLE product_image (
    image_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(product_id),
    image_url TEXT NOT NULL,
    alt_text VARCHAR(255)
);

CREATE TABLE color (
    color_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_value VARCHAR(7)
);

CREATE TABLE size_category (
    size_category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE size_option (
    size_option_id SERIAL PRIMARY KEY,
    size_category_id INT REFERENCES size_category(size_category_id),
    label VARCHAR(50) NOT NULL,
    value VARCHAR(50)
);

CREATE TABLE product_variation (
    variation_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(product_id),
    color_id INT REFERENCES color(color_id),
    size_option_id INT REFERENCES size_option(size_option_id),
    sku VARCHAR(100) UNIQUE,
    additional_price NUMERIC(10, 2)
);

CREATE TABLE product_item (
    item_id SERIAL PRIMARY KEY,
    variation_id INT REFERENCES product_variation(variation_id),
    stock_quantity INT CHECK (stock_quantity >= 0) NOT NULL
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE attribute_category (
    attribute_category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE attribute_type (
    attribute_type_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE product_attribute (
    attribute_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(product_id),
    attribute_category_id INT REFERENCES attribute_category(attribute_category_id),
    attribute_type_id INT REFERENCES attribute_type(attribute_type_id),
    name VARCHAR(100) NOT NULL,
    value TEXT
);


-- =========================================
-- INSERTING SAMPLE DATA
-- =========================================

-- Brands
INSERT INTO brand (name, description) VALUES 
('Nike', 'Global brand specializing in sportswear and equipment'),
('Adidas', 'Well-known for its sports apparel and footwear'),
('Apple', 'Leading brand in consumer electronics and technology');

-- Product Categories
INSERT INTO product_category (name, description) VALUES 
('Footwear', 'Shoes, sandals, and other types of footwear'),
('Electronics', 'Devices such as phones, computers, and accessories'),
('Apparel', 'Clothing items for various purposes');

-- Colors
INSERT INTO color (name, hex_value) VALUES 
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Green', '#00FF00');

-- Size Categories
INSERT INTO size_category (name, description) VALUES 
('Shoe Size', 'Different sizes for shoes'),
('Clothing Size', 'Various clothing sizes');

-- Size Options
INSERT INTO size_option (size_category_id, label, value) VALUES 
(1, 'Small', '7'),
(1, 'Medium', '8'),
(1, 'Large', '9'),
(2, 'Small', 'S'),
(2, 'Medium', 'M'),
(2, 'Large', 'L');

-- Products
INSERT INTO product (name, base_price, description, brand_id, category_id) VALUES 
('Air Max 270', 150.00, 'Comfortable running shoes by Nike', 1, 1),
('Galaxy S23', 799.99, 'Latest smartphone by Samsung', 3, 2),
('T-shirt', 25.00, 'Classic cotton t-shirt by Adidas', 2, 3);

-- Product Images
INSERT INTO product_image (product_id, image_url, alt_text) VALUES 
(1, 'https://example.com/air_max_270.jpg', 'Air Max 270 Sneakers'),
(2, 'https://example.com/galaxy_s23.jpg', 'Galaxy S23 Smartphone'),
(3, 'https://example.com/t_shirt.jpg', 'Adidas Classic T-shirt');

-- Product Variations
INSERT INTO product_variation (product_id, color_id, size_option_id, sku, additional_price) VALUES 
(1, 1, 2, 'AM270_RED_8', 10.00),
(2, 2, 3, 'S23_BLUE_L', 50.00),
(3, 3, 1, 'TSHIRT_GREEN_S', 5.00);

-- Product Items
INSERT INTO product_item (variation_id, stock_quantity, is_available) VALUES 
(1, 100, TRUE),
(2, 50, TRUE),
(3, 200, TRUE);

-- Attribute Categories
INSERT INTO attribute_category (name, description) VALUES 
('Material', 'The material used in the product'),
('Size', 'The size of the product');

-- Attribute Types
INSERT INTO attribute_type (name) VALUES 
('Color'),
('Fabric');

-- Product Attributes
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES 
(1, 1, 1, 'Color', 'Red'),
(2, 2, 2, 'Material', 'Plastic'),
(3, 1, 1, 'Color', 'Green');
