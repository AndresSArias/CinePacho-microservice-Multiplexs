package com.pragma.powerup.usermicroservice.adapters.driving.http.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class QualificationRequestDto {
    private String numberDocument;
    private String idInvoice;
    private String qualificationMovie;
}
