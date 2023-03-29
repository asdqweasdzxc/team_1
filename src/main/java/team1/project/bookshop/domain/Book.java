package team1.project.bookshop.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;



@Data
public class Book {
		
	private int book_idx; //pk
	private BookSubCategory bookSubCategory; //fk
	private String book_name;
	private String writer;
	private String summary;
	private String publisher;
	private String create_date;
	private String admin_name;
	private int price;
	private int discount;
	private int point;
	private BookType bookType; //fk	
	private MultipartFile myfile;//저장할 파일
	private String filename;//db에 저장될 파일이름

}
