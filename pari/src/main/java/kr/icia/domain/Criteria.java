package kr.icia.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
private int pageNum;//페이지 번호
private int amount; //페이지당 게시물수 
private String type; // 검색 타입. 내용 +제목+작성자
private String keyword;// 검색어 

private String tp;//카테

public Criteria(){
	this(1,10);
	
}

public Criteria(int pageNum, int amount) {
	this.pageNum=pageNum;
	this.amount=amount;
}
public String[] getTypeArr() {

	return type == null ? new String[] {} : type.split("");
	// 검색타입이 널이라면 비여있는 문자열 배열을 만들고 그렇지 않다면 검색타입을 한
	//글자씩 잘라서 문자열 배열로 만듦
	}
}
