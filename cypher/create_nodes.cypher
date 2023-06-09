//Create Nodes

// Create orders
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/orders.csv' AS row
MERGE (order:Order {orderID: row.OrderID})
  ON CREATE SET order.shipName = row.ShipName;

// Create products
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/products.csv' AS row
MERGE (product:Product {productID: row.ProductID})
  ON CREATE SET product.productName = row.ProductName, product.unitPrice = toFloat(row.UnitPrice);

// Create suppliers
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/suppliers.csv' AS row
MERGE (supplier:Supplier {supplierID: row.SupplierID})
  ON CREATE SET supplier.companyName = row.CompanyName;

// Create employees
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/employees.csv' AS row
MERGE (e:Employee {employeeID:row.EmployeeID})
  ON CREATE SET e.firstName = row.FirstName, e.lastName = row.LastName, e.title = row.Title;

// Create categories
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/categories.csv' AS row
MERGE (c:Category {categoryID: row.CategoryID})
  ON CREATE SET c.categoryName = row.CategoryName, c.description = row.Description;

LOAD CSV WITH HEADERS FROM "https://data.neo4j.com/northwind/customers.csv" AS row
MERGE (n:Customer)
  ON CREATE SET n = row

MATCH (o:Order) return o LIMIT 5;
MATCH (p:Product) return p LIMIT 5;
MATCH (s:Supplier) return s LIMIT 5;
MATCH (e:Employee) return e LIMIT 5;
MATCH (c:Category) return c LIMIT 5;

