package team1.project.bookshop.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import lombok.Data;



//페이징 처리 계산을 담당하는 객체
@Data
public class PageManager2 {
	private int totalRecord; //총 레코드수 
	private int pageSize=9; //페이지당 보여질 레코드 수 
	private int totalPage; //총 페이지 수 
	private int blockSize=10; //블럭당 보여질 페이지 수 
	private int currentPage=1; //현재 페이지 
	private int firstPage; //블럭당 시작 페이지 
	private int lastPage;//블럭당 마지막 페이지
	private int curPos; //페이지당 ArrayList 의 시작 index 
	private int num; //페이지당 시작 번호 
	
	public void init(List list) {
		totalRecord = list.size();
		totalPage = (int)Math.ceil((float)totalRecord/pageSize);
		
	
		firstPage = currentPage - (currentPage-1)%blockSize;
		lastPage = firstPage + (blockSize-1);
		curPos  = (currentPage-1)*pageSize;
		num = totalRecord-curPos;
	}
	
}
