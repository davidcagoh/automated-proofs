#!/usr/bin/env python3
"""Submit a proof request to Aristotle and exit. Returns a project ID.
When Aristotle emails you that it's done, run:

    python retrieve.py <project-id>

Usage:
    python prove.py "Prove that sqrt(2) is irrational"
    python prove.py "Fill in the sorries" --project-dir ./AutomatedProofs
"""

import asyncio
import os
import pathlib
import sys

import aristotlelib
from aristotlelib import Project, AristotleAPIError


def load_env() -> None:
    env = pathlib.Path(".env")
    if env.exists():
        for line in env.read_text().splitlines():
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                k, _, v = line.partition("=")
                os.environ.setdefault(k.strip(), v.strip())


async def main() -> None:
    load_env()

    args = sys.argv[1:]
    if not args or args[0] in ("-h", "--help"):
        print(__doc__)
        sys.exit(0)

    project_dir = None
    if "--project-dir" in args:
        idx = args.index("--project-dir")
        project_dir = args[idx + 1]
        args = args[:idx] + args[idx + 2:]

    prompt = " ".join(args)

    try:
        if project_dir:
            project = await Project.create_from_directory(
                prompt=prompt,
                project_dir=project_dir,
            )
        else:
            project = await Project.create(prompt=prompt)
    except AristotleAPIError as e:
        print(f"Failed to submit: {e}")
        sys.exit(1)

    print(f"Submitted. Project ID: {project.project_id}")
    print(f"\nWhen Aristotle emails you, run:")
    print(f"  python retrieve.py {project.project_id}")


asyncio.run(main())
