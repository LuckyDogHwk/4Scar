package com.car4s.servlet;

import com.car4s.entity.Car;
import com.car4s.entity.User;
import com.car4s.service.CarService;
import com.car4s.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * 汽车管理控制器
 * 处理汽车信息的增删改查请求
 */
@WebServlet("/car")
public class CarServlet extends HttpServlet {
    private final CarService carService = new CarService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            listCars(req, resp);
        } else if ("my".equals(action)) {
            myCars(req, resp);
        } else if ("delete".equals(action)) {
            deleteCar(req, resp);
        } else if ("edit".equals(action)) {
            editCar(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            addCar(req, resp);
        } else if ("update".equals(action)) {
            updateCar(req, resp);
        }
    }

    private void listCars(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Car> cars = carService.getAllCars();
        req.setAttribute("cars", cars);
        req.getRequestDispatcher("/admin/cars.jsp").forward(req, resp);
    }

    private void myCars(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        List<Car> cars = carService.getCarsByOwnerId(user.getId());
        req.setAttribute("cars", cars);
        req.getRequestDispatcher("/owner/cars.jsp").forward(req, resp);
    }

    private void addCar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        String plateNumber = req.getParameter("plateNumber");
        String brand = req.getParameter("brand");
        String model = req.getParameter("model");
        String purchaseDate = req.getParameter("purchaseDate");
        String vin = req.getParameter("vin");
        String maintenanceCycle = req.getParameter("maintenanceCycle");
        String imageUrl = req.getParameter("imageUrl");
        
        Car car = new Car();
        car.setOwnerId(user.getId());
        car.setPlateNumber(plateNumber);
        car.setBrand(brand);
        car.setModel(model);
        if (purchaseDate != null && !purchaseDate.isEmpty()) {
            car.setPurchaseDate(LocalDate.parse(purchaseDate));
        }
        car.setVin(vin);
        if (maintenanceCycle != null && !maintenanceCycle.isEmpty()) {
            car.setMaintenanceCycle(Integer.parseInt(maintenanceCycle));
        } else {
            car.setMaintenanceCycle(5000);
        }
        car.setImageUrl(imageUrl);
        
        if (carService.addCar(car)) {
            resp.sendRedirect(req.getContextPath() + "/car?action=my");
        } else {
            req.setAttribute("error", "车牌号已存在");
            req.getRequestDispatcher("/owner/car-add.jsp").forward(req, resp);
        }
    }

    private void editCar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        Car car = carService.getCarById(id);
        req.setAttribute("car", car);
        req.getRequestDispatcher("/owner/car-edit.jsp").forward(req, resp);
    }

    private void updateCar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        String plateNumber = req.getParameter("plateNumber");
        String brand = req.getParameter("brand");
        String model = req.getParameter("model");
        String purchaseDate = req.getParameter("purchaseDate");
        String vin = req.getParameter("vin");
        String maintenanceCycle = req.getParameter("maintenanceCycle");
        String imageUrl = req.getParameter("imageUrl");
        
        Car car = carService.getCarById(id);
        car.setPlateNumber(plateNumber);
        car.setBrand(brand);
        car.setModel(model);
        if (purchaseDate != null && !purchaseDate.isEmpty()) {
            car.setPurchaseDate(LocalDate.parse(purchaseDate));
        }
        car.setVin(vin);
        if (maintenanceCycle != null && !maintenanceCycle.isEmpty()) {
            car.setMaintenanceCycle(Integer.parseInt(maintenanceCycle));
        }
        car.setImageUrl(imageUrl);
        
        carService.updateCar(car);
        resp.sendRedirect(req.getContextPath() + "/car?action=my");
    }

    private void deleteCar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.parseLong(req.getParameter("id"));
        carService.deleteCar(id);
        resp.sendRedirect(req.getContextPath() + "/car?action=my");
    }
}
