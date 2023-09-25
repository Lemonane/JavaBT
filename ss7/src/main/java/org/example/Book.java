package org.example;

import java.util.Scanner;

public class Book {
    private String bookId;
    private String bookName;
    private double price;
    private String author;
    private boolean status;
    private int catalogId;

    public Book(String bookId, String bookName, double price, String author, boolean status, int catalogId) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.price = price;
        this.author = author;
        this.status = status;
        this.catalogId = catalogId;
    }
    public Book(Scanner scanner){

    }

    public void inputData(Scanner scanner)
    {
        System.out.println("Add name:");
        do {
            bookName = scanner.nextLine();
            if (bookName.length() < 10 || bookName.length() > 50) {
                throw new IllegalArgumentException("Book name must be between 10 and 50 characters");
            }
            break;
        } while (true);
        System.out.println("Add Id:");
        do {
            bookId = scanner.nextLine();
            if (!bookId.startsWith("B") || bookId.length() != 4) {
                throw new IllegalArgumentException("Book ID must start with 'B' and have 4 characters");
            }
            break;
        } while (true);
        System.out.println("Add Id:");
        do {
            if (price <= 0) {
                throw new IllegalArgumentException("Price must be greater than 0");
            }
            break;
        } while (true);
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }
}
