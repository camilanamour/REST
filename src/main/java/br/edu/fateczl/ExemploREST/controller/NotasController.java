package br.edu.fateczl.ExemploREST.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.edu.fateczl.ExemploREST.model.dto.SaveNotaDTO;
import br.edu.fateczl.ExemploREST.model.entity.Notas;
import br.edu.fateczl.ExemploREST.persistence.AlunoRepository;
import br.edu.fateczl.ExemploREST.persistence.DisciplinaRepository;
import br.edu.fateczl.ExemploREST.persistence.NotasRepository;

@RestController
@RequestMapping("/rest")
public class NotasController implements INotaController {

	@Autowired
	private NotasRepository repository;
	
	@Autowired
    private AlunoRepository alunoRepository;

    @Autowired
    private DisciplinaRepository disciplinaRepository;

    @Override
    @PostMapping("/notas")
    public ResponseEntity<String> saveNota(@RequestBody @Valid List<SaveNotaDTO> ntos) {
        for (SaveNotaDTO dto : ntos) {
            repository.saveNotas(dto.getRa(),dto.getCodigoDisciplina(),dto.getCodigoAvaliacao(),dto.getNota());
        }
        return ResponseEntity.ok("Notas contabilizadas");
    }

    @Override
    @GetMapping("/notas/{codigo}")
    public ResponseEntity<List<Notas>> getNota(@PathVariable String codigo) {
        return ResponseEntity.ok(repository.findAllByDisciplina(disciplinaRepository.findById(codigo).orElseThrow()));
    }

    @PutMapping("/nota")
    public ResponseEntity<String> updateFalta(@RequestBody @Valid List<SaveNotaDTO> dtos) {
        for (SaveNotaDTO dto :
                dtos) {
            repository.updateNotas(dto.getRa(),dto.getCodigoDisciplina(),dto.getCodigoAvaliacao(),dto.getNota());
        }
        return ResponseEntity.ok("Notas atualizadas");
    }


}
