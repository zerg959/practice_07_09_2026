-- drop old tables
DROP TABLE IF EXISTS sales_items CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS partners CASCADE;

-- partners
CREATE TABLE IF NOT EXISTS partners (
    id SERIAL PRIMARY KEY,
    inn VARCHAR(12) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL,
    company_name VARCHAR(200),
    phone VARCHAR(50),
    rating DECIMAL(3,1),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- products
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    article VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(100) NOT NULL,
    description VARCHAR(300),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- sales
CREATE TABLE IF NOT EXISTS sales (
    id SERIAL PRIMARY KEY,
    sale_code VARCHAR(50) NOT NULL UNIQUE,
    partner_id INTEGER REFERENCES partners(id),
    status VARCHAR(20) DEFAULT 'new' CHECK (status IN ('new', 'in progress', 'completed')),
    sale_date DATE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- sales_items
CREATE TABLE IF NOT EXISTS sales_items (
    id SERIAL PRIMARY KEY,
    sale_id INTEGER NOT NULL REFERENCES sales(id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    total DECIMAL(12,2) GENERATED ALWAYS AS (quantity * price) STORED,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- temp_table for import
CREATE TEMP TABLE IF NOT EXISTS temp_sales (
    sale_id INTEGER,
    partner_id INTEGER,
    product_name TEXT,
    sale_date TEXT,
    quantity INTEGER,
    total_amount DECIMAL(10,2)
);