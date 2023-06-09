//Create Relationships

// Create relationships between orders and products
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/orders.csv' AS row
MATCH (order:Order {orderID: row.OrderID})
MATCH (product:Product {productID: row.ProductID})
MERGE (order)-[op:CONTAINS]->(product)
  ON CREATE SET op.unitPrice = toFloat(row.UnitPrice), op.quantity = toFloat(row.Quantity);

// Create relationships between orders and employees
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/orders.csv' AS row
MATCH (order:Order {orderID: row.OrderID})
MATCH (employee:Employee {employeeID: row.EmployeeID})
MERGE (employee)-[:SOLD]->(order);

// Create relationships between products and suppliers
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/products.csv' AS row
MATCH (product:Product {productID: row.ProductID})
MATCH (supplier:Supplier {supplierID: row.SupplierID})
MERGE (supplier)-[:SUPPLIES]->(product);

// Create relationships between products and categories
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/products.csv' AS row
MATCH (product:Product {productID: row.ProductID})
MATCH (category:Category {categoryID: row.CategoryID})
MERGE (product)-[:PART_OF]->(category);

// Create relationships between employees (reporting hierarchy)
LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/employees.csv' AS row
MATCH (employee:Employee {employeeID: row.EmployeeID})
MATCH (manager:Employee {employeeID: row.ReportsTo})
MERGE (employee)-[:REPORTS_TO]->(manager);

LOAD CSV WITH HEADERS FROM 'https://gist.githubusercontent.com/PedroDDiez/d2403112fca28d9ac186e0efc67e8240/raw/f42c31461599acdc22c4f566e44ee164a0e0b4b2/orders.csv' AS row
MATCH (customer:Customer {customerID: row.CustomerID})
MATCH (order:Order {orderID: row.OrderID})
MERGE (customer)-[:PURCHASED]->(order)

MATCH (o:Order)-[]-(p:Product) RETURN o,p LIMIT 10;
MATCH (o:Order)-[]-(e:Employee) RETURN o,e LIMIT 10;
MATCH (s:Supplier)-[]-(p:Product) RETURN s,p LIMIT 10;
MATCH (c:Category)-[]-(p:Product) RETURN c,p LIMIT 10;
MATCH (e1:Employee)-[]-(e2:Employee) RETURN e1,e2 LIMIT 10;



