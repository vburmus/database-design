package com.wust.entities;

import com.wust.entities.primarykeys.EntryPK;
import jakarta.persistence.*;
import lombok.*;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

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
    @Column(nullable = false)
    private Integer quantity;
    @Column(nullable = false, length = 45)
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
    @Enumerated(EnumType.STRING)
    private Status status;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Entry entry = (Entry) o;
        return new EqualsBuilder().append(entryPK, entry.entryPK).append(quantity, entry.quantity).append(dosage, entry.dosage).append(status, entry.status).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(entryPK).append(quantity).append(dosage).append(status).toHashCode();
    }
}