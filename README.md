# Ecommerce-Database-System-Design-and-Implementation
Database schema and EER design for a scalable ecommerce platform.

This project showcases a fully normalized, relational database system designed for a modern ecommerce platform. It includes a comprehensive **EER (Enhanced Entity-Relationship) diagram**, **SQL schema**, and logical design documentation.

## 📘 Overview

The database supports essential ecommerce operations such as:

- User registration and customer management
- Product cataloging and categorization
- Shopping cart functionality
- Order tracking and processing
- Inventory control
- Delivery scheduling
- Employee roles and access control

This system was designed with scalability, data integrity, and real-world applicability in mind.

---

## ⚙️ Tech Stack

- **MySQL Workbench** – SQL scripting and schema validation
- **draw.io** – ERD design and modeling
- **GitHub** – Version control and collaboration

---

## 📁 Project Structure

| File | Description |
|------|-------------|
| `ecommerce_schema.sql` | SQL script that creates the entire ecommerce database schema |
| `eer-diagram.png` | Visual export of the EER diagram for quick reference |

---

## 🧠 Key Entities

Some of the core entities modeled in the system include:

- `CUSTOMERS`
- `PRODUCTS`
- `ORDERS` and `ORDER_ITEMS`
- `CATEGORIES`
- `EMPLOYEES`, with subclasses like `DRIVERS` and `CLERKS`
- `DELIVERIES`
- `INVENTORY`
- `ROLES` and `PERMISSIONS`

All tables use UUIDs for primary keys, and triggers are implemented to normalize specific fields during inserts/updates.

---

## 🖼 ER Diagram Preview

![EER Diagram](eer-diagram.png)

---

## 🚀 Use Cases

This database design can be adapted for:

- E-commerce startups building out their backend
- Academic database design projects
- Backend engineers designing scalable data models
- Transport or logistics platforms with ecommerce features

---

## 🧾 License

This project is open source and available under the [MIT License](LICENSE) (or specify your own license).

---

## 🙌 Author

Designed and implemented by **Nana Boakye-Yiadom**
