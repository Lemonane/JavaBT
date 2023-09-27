package org.example.Service;

import java.util.Scanner;

public interface ProductService {
    void displayProducts();

    void displayProductsByPrice();

    void addProduct(Scanner scanner);

    void updateProduct(Scanner scanner);

    void updateProductStatus(Scanner scanner);

    void deleteProduct(Scanner scanner);

    void searchProductByName(Scanner scanner);

    void searchProductByPriceRange(Scanner scanner);

    void sellProduct(Scanner scanner);
}
