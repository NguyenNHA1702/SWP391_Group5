package model;

import java.time.LocalDate;

public class Campaign {
    private int id;
    private String title;
    private String description;
    private double goalAmount;
    private double currentAmount;
    private LocalDate startDate;
    private LocalDate endDate;

    public Campaign(int id, String title, String description, double goalAmount, double currentAmount, LocalDate startDate, LocalDate endDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.goalAmount = goalAmount;
        this.currentAmount = currentAmount;
        this.startDate = startDate;
        this.endDate = endDate;
    }
}
