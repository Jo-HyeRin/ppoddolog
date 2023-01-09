package com.example.ppoddolog.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.ppoddolog.config.CustomApiException;
import com.example.ppoddolog.config.CustomException;
import com.example.ppoddolog.service.UsersService;
import com.example.ppoddolog.web.dto.ResponseDto;
import com.example.ppoddolog.web.dto.users.AddressDto;
import com.example.ppoddolog.web.dto.users.DetailUsersDto;
import com.example.ppoddolog.web.dto.users.SignedDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.JoinDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.LoginDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.PasswordDto;
import com.example.ppoddolog.web.dto.users.UsersReqDto.UpdateDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class UsersController {

    private final UsersService usersService;
    private final HttpSession session;

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping({ "/", "/main" })
    public String main() {
        return "main";
    }

    @GetMapping("/joinForm")
    public String joinForm() {
        return "/users/joinForm";
    }

    @PostMapping("/join")
    public @ResponseBody ResponseEntity<?> join(@RequestPart("file") MultipartFile file,
            @RequestPart("joinDto") JoinDto joinDto) throws Exception {
        int pos = file.getOriginalFilename().lastIndexOf('.');
        String extension = file.getOriginalFilename().substring(pos + 1);
        String filePath = "C:\\Users\\1\\Desktop\\workplace\\ppoddolog\\src\\main\\resources\\static\\img";
        String imgSaveName = UUID.randomUUID().toString();
        String imgName = imgSaveName + "." + extension;
        File makeFileFolder = new File(filePath);
        if (!makeFileFolder.exists()) {
            if (!makeFileFolder.mkdir()) {
                throw new Exception("File.mkdir():Fail.");
            }
        }
        File dest = new File(filePath, imgName);
        try {
            Files.copy(file.getInputStream(), dest.toPath());
        } catch (IOException e) {
            e.printStackTrace();
        }
        joinDto.setPhoto(imgName);
        usersService.회원가입(joinDto);
        return new ResponseEntity<>(new ResponseDto<>(1, "회원가입 성공", HttpStatus.CREATED), HttpStatus.CREATED);
    }

    @GetMapping("/loginForm")
    public String loginForm(Model model, HttpServletRequest request) {
        // 자동 로그인 쿠키
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                model.addAttribute(cookie.getName(), cookie.getValue());
            }
        }
        return "/users/loginForm";
    }

    @PostMapping("/login")
    public @ResponseBody ResponseEntity<?> login(@RequestBody LoginDto loginDto, HttpServletResponse response) {
        // 자동 로그인 쿠키
        if (loginDto.isRemember()) {
            Cookie cookie = new Cookie("username", loginDto.getUsername());
            cookie.setMaxAge(60 * 60 * 24);
            response.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("username", null);
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }

        // 로그인
        SignedDto principal = usersService.로그인(loginDto);
        if (principal == null) {
            throw new CustomApiException("로그인 실패", HttpStatus.FORBIDDEN);
        }
        session.setAttribute("principal", principal);
        return new ResponseEntity<>(new ResponseDto<>(1, "로그인 성공", HttpStatus.OK), HttpStatus.OK);
    }

    @GetMapping("/logout")
    public String logout() {
        session.invalidate();
        return "redirect:/main";
    }

    @GetMapping("/users/{usersId}/detail")
    public String detailUsers(@PathVariable Integer usersId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 상세보기
        DetailUsersDto usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/users/detailUsers";
    }

    @GetMapping("/users/{usersId}/update")
    public String updateForm(@PathVariable Integer usersId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 본인 정보 뷰 전달
        AddressDto usersAddress = usersService.주소정보(usersId);
        model.addAttribute("usersAddress", usersAddress);
        DetailUsersDto usersPS = usersService.상세보기(usersId);
        model.addAttribute("usersPS", usersPS);
        return "/users/updateUsersForm";
    }

    @PutMapping("/users/{usersId}/update")
    public @ResponseBody ResponseEntity<?> updateUsers(@RequestPart("file") MultipartFile file,
            @RequestPart("updateDto") UpdateDto updateDto, @PathVariable Integer usersId) throws Exception {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 이미지 저장
        int pos = file.getOriginalFilename().lastIndexOf('.');
        String extension = file.getOriginalFilename().substring(pos + 1);
        String filePath = "C:\\Users\\1\\Desktop\\workplace\\ppoddolog\\src\\main\\resources\\static\\img";
        String imgSaveName = UUID.randomUUID().toString();
        String imgName = imgSaveName + "." + extension;
        File makeFileFolder = new File(filePath);
        if (!makeFileFolder.exists()) {
            if (!makeFileFolder.mkdir()) {
                throw new Exception("File.mkdir():Fail.");
            }
        }
        File dest = new File(filePath, imgName);
        try {
            Files.copy(file.getInputStream(), dest.toPath());
        } catch (IOException e) {
            e.printStackTrace();
        }
        updateDto.setPhoto(imgName);
        // 유저수정
        usersService.유저수정(updateDto, usersId);
        return new ResponseEntity<>(new ResponseDto<>(1, "유저수정 성공", HttpStatus.OK), HttpStatus.OK);
    }

    @GetMapping("/users/{usersId}/updatePassword")
    public String updatePasswordForm(@PathVariable Integer usersId, Model model) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 뷰 응답
        return "/users/updatePasswordForm";
    }

    @PutMapping("/users/{usersId}/updatePassword")
    public @ResponseBody ResponseEntity<?> updatePassword(@RequestBody PasswordDto passwordDto,
            @PathVariable Integer usersId) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 비밀번호 변경
        usersService.비밀번호변경(passwordDto, usersId);
        return new ResponseEntity<>(new ResponseDto<>(1, "비밀번호변경 성공", HttpStatus.OK), HttpStatus.OK);
    }

    @PutMapping("/users/{usersId}/leave")
    public @ResponseBody ResponseEntity<?> leaveUsers(@PathVariable Integer usersId) {
        // 로그인유저 = 요청유저 확인
        SignedDto principal = (SignedDto) session.getAttribute("principal");
        if (principal.getUsersId() != usersId) {
            throw new CustomApiException("본인이 아닙니다.", HttpStatus.FORBIDDEN);
        }
        // 유저탈퇴
        usersService.유저비활성화(usersId);
        session.invalidate();
        return new ResponseEntity<>(new ResponseDto<>(1, "유저탈퇴 성공", HttpStatus.OK), HttpStatus.OK);
    }

}
