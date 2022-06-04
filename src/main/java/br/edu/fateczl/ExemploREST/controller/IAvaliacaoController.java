package br.edu.fateczl.ExemploREST.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;

import br.edu.fateczl.ExemploREST.model.dto.AvaliacaoDTO;
import br.edu.fateczl.ExemploREST.model.entity.Avaliacao;

public interface IAvaliacaoController {
	public List<AvaliacaoDTO> buscarAvaliacao();
	public ResponseEntity<AvaliacaoDTO> buscarAvaliacao(int codigo);
	public ResponseEntity<String> insereAvaliacao(Avaliacao avaliacao);
	public ResponseEntity<String> atualizaAvaliacao(Avaliacao avaliacao);
	public ResponseEntity<String> excluiAvaliacao(Avaliacao avaliacao);
}
