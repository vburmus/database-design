package com.wust.entities;

import com.wust.entities.primarykeys.EntryPK;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Entry {
    @EmbeddedId
    private EntryPK entryPK;
    private Integer quantity;
    private String dosage;
    private String annotation;
    @ManyToOne
    @MapsId("medicineId")
    private Medicine medicine;
    @ManyToOne
    @MapsId("prescriptionId")
    private Prescription prescription;
    @ManyToOne
    @JoinColumn(name = "pharmacy_id", referencedColumnName = "id")
    private Pharmacy pharmacy;
    @ManyToOne
    @JoinColumn(name = "pharmacist_id", referencedColumnName = "id")
    private Pharmacist pharmacist;
    @Enumerated
    private Status status;
}