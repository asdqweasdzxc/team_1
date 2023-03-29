package team1.project.bookshop.domain;

import lombok.Data;

@Data
public class BookSubCategory {
	private int bookSubCategory_idx;
	private BookTopCategory bookTopCategory;
	private String bookSubCategory_name;
	
}
