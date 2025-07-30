import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get()
  getHello(): string {
    return 'Nest está rodando com HTTPS via Traefik 🎉';
  }
}
