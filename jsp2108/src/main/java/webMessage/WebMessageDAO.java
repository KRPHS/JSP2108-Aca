package webMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;

public class WebMessageDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private WebMessageVO vo = null;

	// 메시지 가져오기 (전체메시지/새메시지/보낸메시지/휴지통)
	public List<WebMessageVO> getWebMessageList(String mid, int mSw) {
		List<WebMessageVO> vos = new ArrayList<WebMessageVO>();
		try {
			if(mSw == 1) { // 받은메시지처리
				sql = "select * from webMessage where receiveId = ? && (receiveSw='n' || receiveSw='r') order by idx desc";
			} else if(mSw == 2) {
				sql = "select * from webMessage where receiveId = ? && receiveSw='n' order by idx desc";
			} else if(mSw == 3) {
				sql = "select * from webMessage where sendId = ? && sendSw='s' order by idx desc";
			} else if(mSw == 4) {
				sql = "select * from webMessage where sendId = ? && receiveSw='n' order by idx desc";
			} else if(mSw == 5) {
				sql = "select * from webMessage where (receiveId = ? && receiveSw='g') || (sendId = ? && sendSw='g') order by idx desc";
			}
			else return vos;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if(mSw == 5) pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new WebMessageVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveDate(rs.getString("receiveDate"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	public int setWmInputOk(WebMessageVO vo) {
		int res = 0;
		try {
			sql = "select mid from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getReceiveId());
			rs = pstmt.executeQuery();
			if(!rs.next()) return res;
			getConn.pstmtClose();
			
			sql = "insert into webMessage values (default,?,?,?,'s',default,?,'n',default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getSendId());
			pstmt.setString(4, vo.getReceiveId());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}

	public WebMessageVO getWmMessageOne(int idx, String mid) {
		vo = new WebMessageVO();
		try {
			// 신규메시지를 읽게되면 receiveSw의 n > r
			sql = "update webMessage set receiveSw='r', receiveDate=now() where idx=? and (sendId != ?)";
//			sql = "update webMessage set receiveSw='r', receiveDate=now() where idx=? and receiveId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "select * from webMessage where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(idx);
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveDate(rs.getString("receiveDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	public int setWmDeleteCheck(int idx, String mFlag) {
		int res = 0;
		try {
			if(mFlag.equals("s")) {
				sql = "update webMessage set sendSw='g' where idx=?";
			} else {
				sql = "update webMessage set receiveSw='g' where idx=?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// receiveSw의 g를 x로 변경처리
	public void setWmDeleteAll(String mid) {
		try {
			sql = "update webMessage set receiveSw='x' where receiveId=? and receiveSw='g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "update webMessage set sendSw='x' where sendId=? and sendSw='g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL에러 :: " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
}
