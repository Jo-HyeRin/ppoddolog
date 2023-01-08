package com.example.ppoddolog.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.config.CustomException;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.admin.UsersListDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;
import com.example.ppoddolog.web.dto.users.SignedDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AdminController {

    private final UsersService usersService;
    private final HttpSession session;

    @GetMapping("/admin/{adminId}/activeUsersList")
    public String activeUsersList(@PathVariable Integer adminId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        System.out.println("디버그: " + principal.getRole());
        if (principal.getUsersId() != adminId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 뷰 응답
        List<UsersListDto> usersList = usersService.활동회원목록(adminId);
        model.addAttribute("usersList", usersList);
        return "/admin/activeUsersList";
    }

    @GetMapping("/admin/{adminId}/stopUsersList")
    public String stopUsersList(@PathVariable Integer adminId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != adminId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 뷰 응답
        List<UsersListDto> usersList = usersService.정지회원목록(adminId);
        model.addAttribute("usersList", usersList);
        return "/admin/stopUsersList";
    }

    @GetMapping("/admin/{adminId}/leaveUsersList")
    public String leaveUsersList(@PathVariable Integer adminId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != adminId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 뷰 응답
        List<UsersListDto> usersList = usersService.탈퇴회원목록(adminId);
        model.addAttribute("usersList", usersList);
        return "/admin/leaveUsersList";
    }

    @GetMapping("/admin/{adminId}/detailUsers/{usersId}")
    public String detailUsers(@PathVariable Integer adminId, @PathVariable Integer usersId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != adminId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 뷰 응답
        DetailUsersDto usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/admin/detailUsers";
    }

    @PutMapping("/admin/{adminId}/stopUsers/{usersId}")
    public @ResponseBody ResponseEntity<?> stopUsers(@PathVariable Integer adminId, @PathVariable Integer usersId) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != adminId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 회원정지
        usersService.회원정지(usersId);
        return new ResponseEntity<>(new ResponseDto<>(1, "회원정지 성공", HttpStatus.OK), HttpStatus.OK);
    }

    @PutMapping("/admin/{adminId}/activeUsers/{usersId}")
    public @ResponseBody ResponseEntity<?> activeUsers(@PathVariable Integer adminId, @PathVariable Integer usersId) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != adminId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 회원정지해제
        usersService.회원정지해제(usersId);
        return new ResponseEntity<>(new ResponseDto<>(1, "회원정지해제 성공", HttpStatus.OK), HttpStatus.OK);
    }

    @DeleteMapping("/admin/{adminId}/deleteUsers/{usersId}")
    public @ResponseBody ResponseEntity<?> deleteUsers(@PathVariable Integer adminId, @PathVariable Integer usersId) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != adminId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 관리자 여부 확인
        if (!principal.getRole().equals("admin")) {
            throw new CustomException("관리자가 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 회원영구삭제
        usersService.회원영구삭제(usersId);
        return new ResponseEntity<>(new ResponseDto<>(1, "회원영구삭제 성공", HttpStatus.OK), HttpStatus.OK);
    }

}
