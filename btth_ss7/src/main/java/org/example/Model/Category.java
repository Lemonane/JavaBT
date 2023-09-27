package org.example.Model;

import java.util.Scanner;

public class Category {
    private String catalogName;
    private int priority;
    private boolean catalogStatus;

    public Category() {
    }

    public Category(String catalogName, int priority, boolean catalogStatus) {
        this.catalogName = catalogName;
        this.priority = priority;
        this.catalogStatus = catalogStatus;
    }

    public String getCatalogName() {
        return catalogName;
    }

    public void setCatalogName(String catalogName) {
        this.catalogName = catalogName;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public boolean isCatalogStatus() {
        return catalogStatus;
    }

    public void setCatalogStatus(boolean catalogStatus) {
        this.catalogStatus = catalogStatus;
    }
    public void inputData(Scanner scanner)
    {
        scanner.nextLine();
        System.out.println("Nhập tên danh mục");
        catalogName = scanner.nextLine();
        System.out.println("Nhập độ ưu tiên");
        priority = scanner.nextInt();
    }
}
