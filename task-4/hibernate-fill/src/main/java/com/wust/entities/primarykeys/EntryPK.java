package com.wust.entities.primarykeys;

import jakarta.persistence.Embeddable;
import lombok.*;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class EntryPK implements Serializable {
    private Long medicineId;
    private Long prescriptionId;
}
