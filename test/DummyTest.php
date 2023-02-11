<?php

declare(strict_types=1);

namespace Braddle\PhpUk2023\Test;

use Braddle\PhpUk2023\DrivingLicence\InvalidDriverException;
use PHPUnit\Framework\TestCase;

class DummyTest extends TestCase
{
    /** @test */
    public function dummyIsTrue(): void
    {
        $this->expectException(InvalidDriverException::class);
        throw new InvalidDriverException();
    }
}