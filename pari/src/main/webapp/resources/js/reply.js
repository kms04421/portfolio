/**
 * 
 */
 
console.log("Reply module......");

var replyService = (function() {

	function add(reply, callback, error) {
		
		console.log("add reply..."+reply+":"+callback+":"+error);		
		$.ajax({
			type:'post',
			url:'/replies/new',			
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result,status,xhr) {
				if (callback) {
					callback(status); 
					console.log("tatus");
				}
			},
			error: function(xhr, status, er) {
				if (error) {
					error(er);
					console.log("error");
				}
			}
		});
	}
	
	// 댓글 목록 가져오기.
	function getList(param, callback, error) {
	
		var gdsNum = param.gdsNum;
		var page = param.page || 1;
	
		$.getJSON("/replies/pages/" + gdsNum + "/" + page,
				function(data) {
					if (callback) {
						//callback(data);
						callback(data.replyTotalCnt, data.list);
					}
				}).fail(function(xhr, status, err) {
			if (error) {
				error(er);
			}
		});
	}	
	
	// 댓글 시간 표시.
	function displayTime(timeValue){
		var today=new Date(); // 현재 시간
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str="";
		
		if(gap<(1000*60*60*24)){ 
		
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();
			
			return [ (hh>9?'':'0')+hh, ':'
				,(mi>9?'':'0')+mi
				,':',(ss>9?'':'0')+ss].join('');
	
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1;
			var dd=dateObj.getDate();
			
			return [yy,'/', (mm>9?'':'0')+mm,'/',
				(dd>9?'':'0')+dd].join('');
		}
	}
	
	function get(rno, callback, error) {
		$.get("/replies/" + rno, function(result) {
			if (callback) {
				callback(result);
				console.log("result"+ result);
				
			console.log("성공"+rno);
			}
		}).fail(function(xhr, status, er) {
			if (error) {
				error(er);
			console.log("실패");
			
			}
		});
	}	
	
	function update(reply, callback, error) {
		console.log("rno: " + reply.rno);
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json;charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
// 덧글 삭제
	function remove(rno, replyer, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			
			data:JSON.stringify({rno:rno,replyer:replyer}),
		 	contentType : "application/json; charset=utf-8",			
			
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}					
	
	return {
		remove: remove,
		update: update,
		add: add,
		getList: getList,
		displayTime: displayTime,
		get: get
	};
})();