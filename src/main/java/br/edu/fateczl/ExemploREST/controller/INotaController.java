package br.edu.fateczl.ExemploREST.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;

import br.edu.fateczl.ExemploREST.model.dto.SaveNotaDTO;
import br.edu.fateczl.ExemploREST.model.entity.Notas;

public interface INotaController {
	
	 ResponseEntity<String> saveNota(List<SaveNotaDTO> ntos);
	 ResponseEntity<List<Notas>> getNota(String codigo);

}
