
CREATE DATABASE IF NOT EXISTS OnlineSalesDB;
USE OnlineSalesDB;

-- 1. Bảng Customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL UNIQUE
);

-- 2. Bảng Categories (Danh mục sản phẩm)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

-- 3. Bảng Products (Sản phẩm)
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    -- Ràng buộc giá > 0
    CONSTRAINT chk_price CHECK (price > 0),
    -- Khóa ngoại tham chiếu đến bảng Categories
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. Bảng Orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Completed', 'Cancel') DEFAULT 'Pending',
    -- Khóa ngoại tham chiếu đến bảng Customers
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Bảng Order_Items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    -- Ràng buộc số lượng > 0
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    -- Khóa ngoại tham chiếu đến bảng Orders
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    -- Khóa ngoại tham chiếu đến bảng Products
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO categories (category_name) VALUES 
('Điện thoại thông minh'),
('Laptop văn phòng'),
('Laptop Gaming'),
('Máy tính bảng'),
('Đồng hồ thông minh'),
('Tai nghe & Âm thanh'),
('Bàn phím cơ'),
('Chuột máy tính'),
('Màn hình PC'),
('Phụ kiện sạc cáp');

INSERT INTO products (product_name, price, category_id) VALUES 
('iPhone 15 Pro Max 256GB', 34990000.00, 1),
('Samsung Galaxy S24 Ultra', 31990000.00, 1),
('MacBook Air M2 2023', 26500000.00, 2),
('Asus ROG Strix G16', 42000000.00, 3),
('iPad Pro 12.9 inch M2', 29990000.00, 4),
('Apple Watch Ultra 2', 21990000.00, 5),
('Sony WH-1000XM5', 6990000.00, 6),
('Keychron Q1 Pro', 4500000.00, 7),
('Logitech MX Master 3S', 2490000.00, 8),
('Màn hình LG UltraGear 27"', 8900000.00, 9);

INSERT INTO customers (customer_name, email, phone) VALUES 
('Nguyễn Hoàng Nam', 'nam.nguyen@gmail.com', '0901112222'),
('Trần Thị Thu Hà', 'ha.tran@outlook.com', '0903334444'),
('Lê Văn Đạt', 'dat.le@yahoo.com', '0915556666'),
('Phạm Minh Tuấn', 'tuan.pham@company.vn', '0987778888'),
('Võ Thanh Hương', 'huong.vo@gmail.com', '0939990000'),
('Đặng Quốc Bảo', 'bao.dang@edu.vn', '0321112233'),
('Bùi Phương Thảo', 'thao.bui@icloud.com', '0334445566'),
('Hồ Tấn Tài', 'tai.ho@gmail.com', '0707778899'),
('Ngô Kiến Huy', 'huy.ngo@showbiz.vn', '0866668888'),
('Lý Nhã Kỳ', 'ky.ly@luxury.com', '0999999999');

INSERT INTO orders (customer_id, order_date, status) VALUES 
(1, '2023-10-01 08:30:00', 'Completed'),
(2, '2023-10-02 09:45:00', 'Completed'),
(3, '2023-10-03 14:20:00', 'Pending'),
(1, '2023-10-05 10:00:00', 'Completed'),
(4, '2023-10-06 16:15:00', 'Cancel'),
(5, '2023-10-07 11:30:00', 'Pending'),
(6, '2023-10-08 19:00:00', 'Completed'),
(7, '2023-10-09 13:45:00', 'Pending'),
(8, '2023-10-10 08:00:00', 'Cancel'),
(9, '2023-10-11 15:30:00', 'Completed');

INSERT INTO order_items (order_id, product_id, quantity) VALUES 
(1, 1, 1), -- Đơn 1 mua 1 cái iPhone 15
(2, 3, 1), -- Đơn 2 mua 1 cái MacBook
(3, 7, 2), -- Đơn 3 mua 2 cái Tai nghe Sony
(4, 10, 1), -- Đơn 4 mua 1 Màn hình
(5, 5, 1), -- Đơn 5 (đã hủy) định mua iPad
(6, 9, 3), -- Đơn 6 mua 3 con chuột Logitech
(7, 2, 1), -- Đơn 7 mua Samsung S24
(8, 8, 1), -- Đơn 8 mua Bàn phím
(9, 6, 2), -- Đơn 9 (đã hủy) định mua 2 cái Apple Watch
(10, 4, 1); -- Đơn 10 mua Laptop Gaming

-- SELECT 
--     o.order_id AS 'Mã Đơn',
--     c.customer_name AS 'Khách Hàng',
--     p.product_name AS 'Sản Phẩm',
--     oi.quantity AS 'SL',
--     FORMAT(p.price, 0) AS 'Đơn Giá',
--     FORMAT(oi.quantity * p.price, 0) AS 'Thành Tiền',
--     o.status AS 'Trạng Thái'
-- FROM orders o
-- JOIN customers c ON o.customer_id = c.customer_id
-- JOIN order_items oi ON o.order_id = oi.order_id
-- JOIN products p ON oi.product_id = p.product_id;

-- phan1: truy van co ban: 
-- cau1:
select*from categories;
-- cau 2:
select*from orders  where status= 'Completed';
-- cau 3:
select*from products order by price DESC;
-- cau4:
select*from products order by price DESC limit 5 offset 2;

-- phan 2: truy van nang cao:
-- cau1:
select p.product_id as 'id', p.product_name as 'ten san pham', c.category_name as 'ten danh muc'  
from products p join categories c on p.category_id =c.category_id;

-- cau2:
select o.order_id as 'ID', o.order_date as 'ngay dat hang', c.customer_name as 'ten khach hang', o.status 
from orders o join customers c on c.customer_id=o.customer_id;

-- cau3:
select o.order_id as 'ID', c.customer_name as 'ten khach hang', o.order_date as 'ngay dat hang', sum(oi.quantity) as 'tong so luong san pham'
from orders o join customers c on c.customer_id=o.customer_id
 join order_items oi on oi.order_id=o.order_id 
group by o.order_id, c.customer_name, o.order_date;

-- cau 4: 
select c.customer_id as'ID', c.customer_name as 'ten khach hang', count(o.order_id) as 'so luong don hang'
from customers c LEFT join orders o on o.customer_id=c.customer_id 
group by c.customer_id, c.customer_name
order by COUNT(o.order_id) desc;

-- CAU 5:
select c.customer_id as'ID', c.customer_name as 'ten khach hang', count(o.order_id) as 'so luong don hang'
from customers c LEFT join orders o on o.customer_id=c.customer_id 
group by c.customer_id, c.customer_name
HAVING count(o.order_id)>=2;

-- cau 6:
SELECT c.category_name AS 'Danh Mục',MIN(p.price) AS 'Giá Thấp Nhất',MAX(p.price) AS 'Giá Cao Nhất',AVG(p.price) AS 'Giá Trung Bình'
FROM categories c JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;

-- phan 3: 
-- cau 1: 
select product_id, product_name, price from products where price >(select avg(price) from products);
-- cau 2:
SELECT 
    customer_id, 
    customer_name
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id FROM orders
);

-- cau 3: 
SELECT 
    o.order_id, 
    SUM(oi.quantity) AS total_quantity
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING SUM(oi.quantity) = (
    SELECT MAX(total_qty) 
    FROM (
        SELECT SUM(quantity) AS total_qty 
        FROM order_items 
        GROUP BY order_id
    ) AS sub_table
);

-- cau 4: 
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category_id = (
    SELECT category_id 
    FROM products
    GROUP BY category_id
    ORDER BY AVG(price) DESC
    LIMIT 1
);

-- cau 5: 
SELECT 
    T.customer_name, 
    T.total_bought
FROM (
    SELECT 
        c.customer_name, 
        SUM(oi.quantity) AS total_bought
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
) AS T
WHERE T.total_bought > 0;
-- cau 6: 
SELECT 
    product_name, 
    FORMAT(price, 0) AS price
FROM products
WHERE price = (
    SELECT MAX(price) FROM products
);
