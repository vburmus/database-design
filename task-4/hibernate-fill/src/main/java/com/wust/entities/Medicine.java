package com.wust.entities;

import jakarta.persistence.*;
import lombok.*;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

import java.util.Set;

@Entity
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Medicine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(unique = true)
    private Long id;
    @Column(nullable = false, length = 5)
    private String permitNumber;
    @Column(nullable = false, length = 45)
    private String name;
    @OneToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH})
    @JoinColumn(name = "pharmaceutical_form_id", referencedColumnName = "id", nullable = false)
    private PharmaceuticalForm pharmaceuticalForm;
    @ManyToOne
    @JoinColumn(name = "category_symbol", referencedColumnName = "symbol", nullable = false)
    private Category category;
    @ManyToMany(cascade = {CascadeType.REFRESH, CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST})
    @JoinTable(name = "medicine_substance",
            joinColumns = @JoinColumn(name = "medicine_id"),
            inverseJoinColumns = @JoinColumn(name = "substance_id"))
    @ToString.Exclude
    private Set<Substance> substances;
    @OneToMany(mappedBy = "medicine")
    @ToString.Exclude
    private Set<Entry> entry;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Medicine medicine = (Medicine) o;

        return new EqualsBuilder().append(id, medicine.id).append(permitNumber, medicine.permitNumber).append(name,
                medicine.name).append(category, medicine.category).isEquals();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(id).append(permitNumber).append(name).append(category).toHashCode();
    }
}