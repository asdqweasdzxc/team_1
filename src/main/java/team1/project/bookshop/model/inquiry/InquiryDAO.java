package team1.project.bookshop.model.inquiry;

import java.util.List;

import team1.project.bookshop.domain.Inquiry;

public interface InquiryDAO {
	public List selectAll();
	public Inquiry select(int inquiry_idx);
	public void insert(Inquiry inquiry);
	public void update(Inquiry inquiry);
	public void delete(int inquiry_idx);
	public void hitUp(int inquiry_idx);
	public List selectByWord(String title);
}
