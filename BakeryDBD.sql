-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `Customer` (
    `CustomerID` int  NOT NULL ,
    `CustomerFirstName` string  NOT NULL ,
    `CustomerLastName` string  NOT NULL ,
    `AddID` int  NOT NULL ,
    `Email` string  NOT NULL ,
    `SocialLink` string  NOT NULL ,
    `Phone` varchar(10)  NOT NULL ,
    `PreferredContact` string  NOT NULL ,
    PRIMARY KEY (
        `CustomerID`
    )
);

CREATE TABLE `Orders` (
    `RowID` int  NOT NULL ,
    `OrderID` varchar(10)  NOT NULL ,
    `CreatedAt` datetime  NOT NULL ,
    `ItemID` int  NOT NULL ,
    `Quantity` int  NOT NULL ,
    `CustomerID` int  NOT NULL ,
    `Delivery` boolean  NOT NULL ,
    `AddID` int  NOT NULL ,
    PRIMARY KEY (
        `RowID`
    )
);

CREATE TABLE `Address` (
    `AddID` int  NOT NULL ,
    `DeliveryAddress1` varchar(200)  NOT NULL ,
    `DeliveryAddress2` varchar(200)  NULL ,
    `DeliveryCity` varchar(50)  NOT NULL ,
    `DeliveryZipCode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `AddID`
    )
);

CREATE TABLE `Item` (
    `ItemID` int  NOT NULL ,
    `SKU` varchar(20)  NOT NULL ,
    `ItemName` varchar(200)  NOT NULL ,
    `ItemCat` varchar(100)  NOT NULL ,
    `ItemSize` varchar(100)  NOT NULL ,
    `ItemPrice` money  NOT NULL ,
    PRIMARY KEY (
        `ItemID`
    ),
    CONSTRAINT `uc_Item_SKU` UNIQUE (
        `SKU`
    ),
    CONSTRAINT `uc_Item_ItemName` UNIQUE (
        `ItemName`
    )
);

CREATE TABLE `Ingredient` (
    `IngID` int  NOT NULL ,
    `IngName` varchar(100)  NOT NULL ,
    `IngWeight` int  NOT NULL ,
    `IngMeas` varchar(20)  NOT NULL ,
    `IngCost` money  NOT NULL ,
    PRIMARY KEY (
        `IngID`
    )
);

CREATE TABLE `Recipe` (
    `RowID` int  NOT NULL ,
    `RecipeID` varchar(20)  NOT NULL ,
    `IngID` varchar(10)  NOT NULL ,
    PRIMARY KEY (
        `RowID`
    )
);

CREATE TABLE `Inventory` (
    `InvId` int  NOT NULL ,
    `ItemId` varchar(10)  NOT NULL ,
    `Quantity` int  NOT NULL ,
    PRIMARY KEY (
        `InvId`
    )
);

CREATE TABLE `Staff` (
    `StaffID` varchar(20)(  NOT NULL ,
    `FirstName` varchar(50)  NOT NULL ,
    `LastName` varchar(50)  NOT NULL ,
    `Position` varchar(100)  NOT NULL ,
    `HourlyRate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `StaffID`
    )
);

CREATE TABLE `Rotation` (
    `RowID` int  NOT NULL ,
    `RotaID` varchar(20)  NOT NULL ,
    `Date` datetime  NOT NULL ,
    `ShiftID` varchar(20)  NOT NULL ,
    `StaffID` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `RowID`
    )
);

CREATE TABLE `Shift` (
    `ShiftID` varchar(20)  NOT NULL ,
    `DayOfWeek` varchar(10)  NOT NULL ,
    `StartTime` time  NOT NULL ,
    `EndTime` time  NOT NULL ,
    PRIMARY KEY (
        `ShiftID`
    )
);

ALTER TABLE `Customer` ADD CONSTRAINT `fk_Customer_AddID` FOREIGN KEY(`AddID`)
REFERENCES `Address` (`AddID`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_ItemID` FOREIGN KEY(`ItemID`)
REFERENCES `Item` (`ItemID`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_CustomerID` FOREIGN KEY(`CustomerID`)
REFERENCES `Customer` (`CustomerID`);

ALTER TABLE `Orders` ADD CONSTRAINT `fk_Orders_AddID` FOREIGN KEY(`AddID`)
REFERENCES `Address` (`AddID`);

ALTER TABLE `Ingredient` ADD CONSTRAINT `fk_Ingredient_IngID` FOREIGN KEY(`IngID`)
REFERENCES `Recipe` (`IngID`);

ALTER TABLE `Recipe` ADD CONSTRAINT `fk_Recipe_RecipeID` FOREIGN KEY(`RecipeID`)
REFERENCES `Item` (`SKU`);

ALTER TABLE `Inventory` ADD CONSTRAINT `fk_Inventory_ItemId` FOREIGN KEY(`ItemId`)
REFERENCES `Recipe` (`IngID`);

ALTER TABLE `Rotation` ADD CONSTRAINT `fk_Rotation_Date` FOREIGN KEY(`Date`)
REFERENCES `Orders` (`CreatedAt`);

ALTER TABLE `Rotation` ADD CONSTRAINT `fk_Rotation_StaffID` FOREIGN KEY(`StaffID`)
REFERENCES `Staff` (`StaffID`);

ALTER TABLE `Shift` ADD CONSTRAINT `fk_Shift_ShiftID` FOREIGN KEY(`ShiftID`)
REFERENCES `Rotation` (`ShiftID`);

