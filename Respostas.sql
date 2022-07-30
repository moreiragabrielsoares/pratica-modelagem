CREATE DATABASE "pratica-modelagem";

CREATE TABLE "customers" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	"cpf" VARCHAR(11) NOT NULL UNIQUE,
	"email" text NOT NULL UNIQUE,
    "password" text NOT NULL
);

CREATE TABLE "bankAccount" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"accountNumber" VARCHAR(7) NOT NULL UNIQUE,
	"agency" VARCHAR(4) NOT NULL,
	"openDate" DATE NOT NULL,
	"closeDate" DATE	
);

CREATE TABLE "transactions" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"amount" INTEGER NOT NULL,
	"type" TEXT NOT NULL,
	"time" TIMESTAMP NOT NULL DEFAULT NOW(),
	"description" TEXT,
	"cancelled" BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE "creditCards" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
	"name" TEXT NOT NULL,
	"number" VARCHAR(16) NOT NULL UNIQUE,
	"securityCode" VARCHAR(3) NOT NULL,
	"expirationMonth" VARCHAR(2) NOT NULL,
	"expirationYear" VARCHAR(4) NOT NULL,
	"password" VARCHAR(4) NOT NULL,
	"limit" INTEGER NOT NULL
);

CREATE TABLE "customerPhones" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
	"number" VARCHAR(15) NOT NULL UNIQUE,
	"type" TEXT NOT NULL
);

CREATE TABLE "states" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL
);


CREATE TABLE "cities" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

CREATE TABLE "customerAddresses" (
	"id" SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES "customers"("id") UNIQUE,
	"street" VARCHAR(200) NOT NULL,
	"number" INTEGER NOT NULL,
	"complement" VARCHAR(200),
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);