package br.edu.fateczl.ExemploREST.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.edu.fateczl.ExemploREST.model.dto.AvaliacaoDTO;
import br.edu.fateczl.ExemploREST.model.dto.DisciplinaDTO;
import br.edu.fateczl.ExemploREST.model.entity.Avaliacao;
import br.edu.fateczl.ExemploREST.model.entity.Disciplina;
import br.edu.fateczl.ExemploREST.persistence.AvaliacaoRepository;

@RestController
@RequestMapping("/rest")
public class AvaliacaoController implements IAvaliacaoController{

	@Autowired
	AvaliacaoRepository aRep;
	
	@Override
	@GetMapping("/avaliacao")
	public List<AvaliacaoDTO> buscarAvaliacao() {
		List<Avaliacao> avaliacoes = aRep.findAll();
		List<AvaliacaoDTO> avaliacaoDTO = 
				convertesDTO(avaliacoes);
		return avaliacaoDTO;
	}

	@GetMapping("/avaliacao/{codigo}")
	public ResponseEntity<AvaliacaoDTO> buscarAvaliacao(@PathVariable(value = "codigo") int codigo) {
		Avaliacao avaliacao = aRep.findById(codigo).orElseThrow();
		AvaliacaoDTO avaliacaoDTO = converteDTO(avaliacao);
		return ResponseEntity.ok().body(avaliacaoDTO);
	}

	@Override
	@PostMapping("/avaliacao")
	public ResponseEntity<String> insereAvaliacao(@Valid @RequestBody Avaliacao avaliacao) {
		aRep.save(avaliacao);
		String saida = "Avaliacao cadastrada com sucesso";
		return ResponseEntity.ok().body(saida);
	}

	@Override
	@PutMapping("/avaliacao")
	public ResponseEntity<String> atualizaAvaliacao(@Valid @RequestBody Avaliacao avaliacao) {
		aRep.save(avaliacao);
		String saida = "Avaliacao atualizada com sucesso";
		return ResponseEntity.ok().body(saida);
	}

	@Override
	@DeleteMapping("/avaliacao")
	public ResponseEntity<String> excluiAvaliacao(@Valid @RequestBody Avaliacao avaliacao) {
		aRep.delete(avaliacao);
		String saida = "Avaliacao excluida com sucesso";
		return ResponseEntity.ok().body(saida);
	}
	
	private AvaliacaoDTO converteDTO(Avaliacao a) {
		AvaliacaoDTO aDTO = new AvaliacaoDTO();
		aDTO.setCodigo(a.getCodigo());
		aDTO.setNome(a.getTipo());

		return aDTO;
	}
	
	private List<AvaliacaoDTO> convertesDTO(List<Avaliacao> avaliacoes) {
		List<AvaliacaoDTO> AvaliacoesDTO = new ArrayList<AvaliacaoDTO>();
		for (Avaliacao a : avaliacoes) {
			AvaliacaoDTO aDTO = new AvaliacaoDTO();
			aDTO.setCodigo(a.getCodigo());
			aDTO.setNome(a.getTipo());
			AvaliacoesDTO.add(aDTO);
		}
		return AvaliacoesDTO;
	}
	
	

}
