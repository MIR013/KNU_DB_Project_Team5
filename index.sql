/*
ALTER TABLE ORDERS DROP foreign key OC1;
ALTER TABLE ORDERS DROP foreign key OI1;
ALTER TABLE ORDERS DROP primary key;
ALTER TABLE ORDERS ADD primary key(Order_no,Customer_id,Item_id);
ALTER TABLE ORDERS ADD CONSTRAINT OC1 FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id);
ALTER TABLE ORDERS ADD CONSTRAINT OI1 FOREIGN KEY (Item_id) REFERENCES ITEM(Item_id);


INSERT INTO CUSTOMER VALUES ('999','999','admin','seoul','01071334301',null,'4',null,null,'lotte');
*/

/*
	insert_shoppingbag.jsp
	query = "SELECT Item_num FROM INCLUDE WHERE Item_id = '"+iid+"' AND Customer_id = '"+cid+"'";
*/
CREATE INDEX insert_sb_itemnum ON INCLUDE (Item_num);

/*
	my page order.jsp
String newquery = "SELECT Order_date, Item_id, Item_num FROM ORDERS WHERE Customer_id = '"+cid+"' AND Order_no = "+ono;
*/
CREATE INDEX order_num ON ORDERS (Order_date, Item_id, Item_num);

/*
	serach category

	query = "SELECT distinct Small_category FROM CATEGORY WHERE Large_category = '" +lcat+"' AND Middle_category = '"+ mcat + "'";
*/

CREATE INDEX search_cat1 ON CATEGORY (Small_category);
CREATE INDEX search_cat2 ON CATEGORY (Middle_category);
CREATE INDEX search_cat3 ON CATEGORY (Large_category);

/*
SELECT Item_id,Item_name FROM ITEM WHERE "
reaserch items
*/
CREATE INDEX search_item ON ITEM (Item_id,Item_name);
